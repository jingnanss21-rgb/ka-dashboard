# 部署指南：餐饮KA摇优惠周报 → Supabase + Vercel

## 总览

| 步骤 | 内容 | 时间 |
|------|------|------|
| 1 | 注册 Supabase，建表 | 10 分钟 |
| 2 | 导入数据 | 15 分钟 |
| 3 | 配置 HTML | 2 分钟 |
| 4 | 部署到 Vercel | 5 分钟 |
| 5 | 发链接给团队 | 1 分钟 |

---

## Step 1：注册 Supabase 并建表

1. 打开 [https://supabase.com](https://supabase.com)，注册账号（免费）
2. 点击 **New Project**，填写项目名（如 `ka-dashboard`），选择离你近的区域（推荐 Singapore 或 Tokyo）
3. 等待项目创建完成（约 1 分钟）
4. 左侧菜单 → **SQL Editor** → 点击 **New Query**
5. 把 `supabase_setup.sql` 的全部内容粘贴进去，点击 **Run**

## Step 2：获取 Supabase 连接信息

1. 左侧菜单 → **Project Settings** → **API**
2. 复制两个值：
   - **Project URL**（形如 `https://abcdefgh.supabase.co`）
   - **anon/public key**（`eyJ...` 开头的长字符串）

## Step 3：导入你的数据

### 方式A：表格编辑器手动导入（推荐新手）

1. 左侧菜单 → **Table Editor**
2. 选择 `ka_brands` 表 → **Insert rows**
3. 把你离线表格的数据逐条粘贴进去

### 方式B：CSV 导入（推荐批量）

1. 把离线表格另存为 CSV
2. Table Editor → 选择表 → **Import data from CSV**

### 方式C：Python 脚本导入（最高效）

```python
from supabase import create_client
import json

url = "https://YOUR_PROJECT_ID.supabase.co"
key = "YOUR_ANON_KEY"
client = create_client(url, key)

# 把你的数据整理成列表，字段名与建表 SQL 一致
brands_data = [
    {"name": "蜜雪冰城", "dailyRedeem": 48888, ...},
    ...
]

# upsert（有则更新，无则插入）
client.table("ka_brands").upsert(brands_data).execute()
```

## Step 4：修改 HTML 配置

打开 `dashboard_supabase.html`，找到文件顶部的配置段落（约第 256 行）：

```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';
```

把 `YOUR_PROJECT_ID` 和 `YOUR_ANON_KEY` 替换为你在 Step 2 复制的值。

## Step 5：部署到 Vercel

### 方式A：直接上传（最简单）

1. 打开 [https://vercel.com](https://vercel.com)，注册账号（免费）
2. 点击 **New Project** → **Import from GitHub** 或直接拖拽文件夹
3. 如果用文件夹：把 `dashboard_supabase.html` 改名为 `index.html` 放进一个空文件夹
4. 拖拽整个文件夹到 Vercel 上传区域
5. 点击 **Deploy**，等待约 30 秒
6. 得到一个 `xxx.vercel.app` 链接，发给所有人！

### 方式B：GitHub + Vercel（推荐，支持自动更新）

1. 在 GitHub 新建一个仓库（private）
2. 把 `dashboard_supabase.html` 改名为 `index.html` 上传
3. Vercel → New Project → 选择这个 GitHub 仓库
4. 以后每次你在 GitHub 更新 `index.html`，Vercel 自动重新部署 ✅

---

## 日常使用流程

### 你每周更新数据：

1. 整理好新一周的数据
2. 打开 Supabase → Table Editor → `ka_brands`
3. 清空旧数据，导入新数据（或用 Python 脚本 upsert）
4. 更新 `ka_overall` 表中的整体指标
5. 所有人刷新页面，立即看到新数据 ✅

### 负责人填写反馈：

1. 打开链接
2. 弹出身份选择，点自己的名字
3. 在对应品牌下填写反馈，保存
4. 老板看板实时同步 ✅

---

## 常见问题

**Q: 数据加载失败怎么办？**
- 检查 `SUPABASE_URL` 和 `SUPABASE_ANON_KEY` 是否填写正确
- 检查 Supabase 项目是否正常运行（不要暂停）
- 检查 RLS 策略是否已创建

**Q: 实时同步不工作？**
- 确认执行了 `ALTER PUBLICATION supabase_realtime ADD TABLE ka_feedbacks;`
- 检查浏览器是否允许 WebSocket 连接

**Q: Supabase 免费额度够用吗？**
- 免费版：500MB 数据库，50万行/月，2个项目
- 你的用例远远够用，不用担心

**Q: 国内访问 Vercel 慢怎么办？**
- 可以改用腾讯云 CloudBase 部署（也支持静态网站托管）
- 或者购买 Vercel 的 Pro 版本启用中国加速

---

*生成时间：2026-03-20 | 改造工具：OpenClaw*
