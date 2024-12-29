-- ����ʱ��ά�ȱ�
CREATE TABLE Dim_Time (
    TimeID INT PRIMARY KEY IDENTITY(1,1),
    timestamp VARCHAR(20) NOT NULL,
    FullDate DATETIME NOT NULL,
    Year INT NOT NULL,
    Month INT NOT NULL,
    Day INT NOT NULL,
    Week INT NOT NULL,
    Hour INT NOT NULL,
    Quarter INT NOT NULL
);

-- �����û�ά�ȱ�
CREATE TABLE Dim_User (
    VisitorID INT PRIMARY KEY
);

-- �����¼�ά�ȱ�
CREATE TABLE Dim_Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventType NVARCHAR(50) NOT NULL
);

-- ��������ά�ȱ�
CREATE TABLE Dim_Category (
    CategoryID INT PRIMARY KEY,
    ParentCategoryID INT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES Dim_Category(CategoryID)
);

-- ��������ά�ȱ�
CREATE TABLE Dim_Property (
    PropertyID INT PRIMARY KEY IDENTITY(1,1),
    PropertyName NVARCHAR(255) NOT NULL,
    CategoryID INT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Dim_Category(CategoryID)
);

-- ������Ʒά�ȱ�
CREATE TABLE Dim_Item (
    ItemID INT PRIMARY KEY,
    PropertyID INT NOT NULL,
    FOREIGN KEY (PropertyID) REFERENCES Dim_Property(PropertyID)
);

-- �����û���Ϊ��ʵ��
CREATE TABLE Fact_UserEvents (
    EventID INT NOT NULL,
    VisitorID INT NOT NULL,
    TimeID INT NOT NULL,
    ItemID INT NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Dim_Event(EventID),
    FOREIGN KEY (VisitorID) REFERENCES Dim_User(VisitorID),
    FOREIGN KEY (TimeID) REFERENCES Dim_Time(TimeID),
    FOREIGN KEY (ItemID) REFERENCES Dim_Item(ItemID)
);

CREATE TABLE Fact_ItemPropertyBridge (
    BridgeID INT IDENTITY(1,1) PRIMARY KEY, -- 桥表唯一标识
    ItemID INT NOT NULL,                    -- 商品ID（外键）
    PropertyID INT NOT NULL,                -- 属性ID（外键）
    PropertyValue NVARCHAR(255),            -- 属性值（如状态、颜色等，可选）
    FOREIGN KEY (ItemID) REFERENCES Dim_Item(ItemID),
    FOREIGN KEY (PropertyID) REFERENCES Dim_Property(PropertyID)
);