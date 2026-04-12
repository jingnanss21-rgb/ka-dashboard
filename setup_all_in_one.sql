DROP TABLE IF EXISTS ka_feedbacks;
DROP TABLE IF EXISTS ka_brands;
DROP TABLE IF EXISTS ka_activities;
DROP TABLE IF EXISTS ka_assignments;
DROP TABLE IF EXISTS ka_overall;

CREATE TABLE ka_brands (id SERIAL PRIMARY KEY, name TEXT NOT NULL UNIQUE, category TEXT, "dailyExposure" FLOAT, "dailyCollect" FLOAT, "dailyRedeem" FLOAT, "exposureRedeemRate" FLOAT, "survivalRate" FLOAT, "isSurvived" INT, "pricePower" FLOAT, "storeRedeemRate" FLOAT, "merchantCompleteness" FLOAT, "storeCompleteness" FLOAT, "highFreqExposureRate" FLOAT, "lowFreqExposureRate" FLOAT, "exposureRedeemRate7d" FLOAT, "lastWeekExposureRedeemRate" FLOAT, "dailyExposure7d" FLOAT, "lastWeekDailyExposure" FLOAT, "dailyRedeem7d" FLOAT, "lastWeekDailyRedeem" FLOAT, "redeemGrowthRate" TEXT, "redeemAbsGrowth" TEXT, "activityCount" FLOAT, "miniProgramRatio" FLOAT, "miniProgramStoreRedeem" FLOAT, "unreachedThreshold7d" FLOAT, "reachedThreshold7d" FLOAT, "totalVisit7d" FLOAT, "exposureCollectRate" FLOAT, "lastWeekExposureCollectRate" FLOAT, "collectRedeemRate" FLOAT, "lastWeekCollectRedeemRate" FLOAT, "oldCustomerDailyExposure" FLOAT, "oldCustomerExposureRedeemRate" FLOAT, "isAlive" TEXT, "unreachedThresholdRate" FLOAT, "dailyPayment" FLOAT, "storeCount" FLOAT, "realStoreCount" FLOAT, "storeUploadCompleteness" FLOAT, "priceCompetitiveness" FLOAT, "arrivalRedeemRate" FLOAT, "notReachThresholdCount" FLOAT, "reachThresholdCount" FLOAT, updated_at TIMESTAMPTZ DEFAULT NOW());

CREATE TABLE ka_activities (id SERIAL PRIMARY KEY, "brandName" TEXT, "activityName" TEXT, "couponName" TEXT, "discountType" TEXT, "discount" FLOAT, "threshold" FLOAT, "thresholdJudge" TEXT, "isWholeStore" INT, "brandAvgPrice" FLOAT, "pricePower" FLOAT, "dailyExposure" FLOAT, "dailyRedeem" FLOAT, "exposureRedeemRate" FLOAT, "exposureCollectRate" FLOAT, "collectRedeemRate" FLOAT, "storeRedeemRate" FLOAT, "unreachedThresholdRate" FLOAT, "coverageTag" TEXT, updated_at TIMESTAMPTZ DEFAULT NOW());

CREATE TABLE ka_assignments (id SERIAL PRIMARY KEY, brand TEXT NOT NULL, category TEXT, owner TEXT, "redeemTarget" FLOAT, "estimatedExposure" FLOAT, "conversionTarget" FLOAT, "dailyExposure" FLOAT, "dailyRedeem" FLOAT, "exposureRedeemRate" FLOAT, "redeemAchieveRate" FLOAT, updated_at TIMESTAMPTZ DEFAULT NOW());

CREATE TABLE ka_overall (id SERIAL PRIMARY KEY, "totalRedeemTarget" FLOAT, "totalDailyRedeem" FLOAT, "overallAchieveRate" FLOAT, "medianExposureRedeemRate" FLOAT, "medianStoreRedeemRate" FLOAT, "medianHighFreqRate" FLOAT, "medianLowFreqRate" FLOAT, "medianPricePower" FLOAT, "totalBrands" INT, "survivedBrands" INT, "activeBrands" INT, data_date TEXT, created_at TIMESTAMPTZ DEFAULT NOW());

CREATE TABLE ka_feedbacks (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, brand_name TEXT NOT NULL, text TEXT NOT NULL, owner TEXT NOT NULL DEFAULT '未知', created_at TIMESTAMPTZ DEFAULT NOW());

ALTER PUBLICATION supabase_realtime ADD TABLE ka_feedbacks;

ALTER TABLE ka_brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE ka_activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE ka_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE ka_overall ENABLE ROW LEVEL SECURITY;
ALTER TABLE ka_feedbacks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow all brands" ON ka_brands FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow all activities" ON ka_activities FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow all assignments" ON ka_assignments FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow all overall" ON ka_overall FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow all feedbacks" ON ka_feedbacks FOR ALL USING (true) WITH CHECK (true);
