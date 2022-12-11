USE SoftwareShop;
CREATE INDEX idx_PlatformID ON Games(PlatformID);
CREATE INDEX idx_RatingID ON Games(RatingID);
CREATE INDEX idx_MemberDiscount ON Memberships(DiscountID);
CREATE INDEX idx_GameID ON ReceiptDetails(GameID);
CREATE INDEX idx_ReceiptDiscount ON ReceiptDetails(DiscountID);