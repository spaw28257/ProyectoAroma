USE [db_aroma]
GO
/****** Object:  StoredProcedure [dbo].[zsp_ListUnitMeasure]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListUnitMeasure]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_ListUnitMeasure]
GO
/****** Object:  StoredProcedure [dbo].[zsp_ListRate]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListRate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_ListRate]
GO
/****** Object:  StoredProcedure [dbo].[zsp_ListInventoryProducts]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListInventoryProducts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_ListInventoryProducts]
GO
/****** Object:  StoredProcedure [dbo].[zsp_ListCategory]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_ListCategory]
GO
/****** Object:  StoredProcedure [dbo].[zsp_EditProduct]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_EditProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_EditProduct]
GO
/****** Object:  StoredProcedure [dbo].[zsp_AddProduct]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_AddProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_AddProduct]
GO
/****** Object:  StoredProcedure [dbo].[zsp_AddEditTasaCambio]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_AddEditTasaCambio]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zsp_AddEditTasaCambio]
GO
/****** Object:  Table [dbo].[tbl_master_unitmeasure]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_unitmeasure]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_master_unitmeasure]
GO
/****** Object:  Table [dbo].[tbl_master_rate]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_rate]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_master_rate]
GO
/****** Object:  Table [dbo].[tbl_master_product]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_product]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_master_product]
GO
/****** Object:  Table [dbo].[tbl_master_category]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_category]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_master_category]
GO
/****** Object:  UserDefinedFunction [dbo].[zfn_GetCurrentRate]    Script Date: 21/06/2023 05:30:34 a. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zfn_GetCurrentRate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[zfn_GetCurrentRate]
GO
/****** Object:  UserDefinedFunction [dbo].[zfn_GetCurrentRate]    Script Date: 21/06/2023 05:30:34 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zfn_GetCurrentRate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Pablo Aponte
-- Create date: 2023-06-14
-- Description:	la función obtiene la tasa de cambio del dia
-- =============================================
CREATE FUNCTION [dbo].[zfn_GetCurrentRate]
(
	@prate_date datetime
)
RETURNS numeric(18,4)
AS
BEGIN
	
	declare @rate numeric(18,4)

	select @rate = rate from tbl_master_rate where rate_date = cast(@prate_date as date)

	RETURN @rate

END
' 
END

GO
/****** Object:  Table [dbo].[tbl_master_category]    Script Date: 21/06/2023 05:30:34 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_master_category](
	[category_id] [int] NOT NULL,
	[category] [nvarchar](100) NOT NULL CONSTRAINT [DF_tbl_master_category_category]  DEFAULT (space((0))),
	[enabled] [nvarchar](1) NOT NULL CONSTRAINT [DF_tbl_master_category_enabled]  DEFAULT (space((0))),
	[created_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_category_created_date]  DEFAULT (space((0))),
	[updated_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_category_updated_date]  DEFAULT (space((0))),
 CONSTRAINT [PK_tbl_master_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[tbl_master_product]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_product]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_master_product](
	[Id] [int] NOT NULL,
	[product] [nvarchar](100) NOT NULL CONSTRAINT [DF_tbl_master_product_product]  DEFAULT (space((0))),
	[unit_measure_id] [int] NOT NULL CONSTRAINT [DF_tbl_master_product_unit_measure_id]  DEFAULT ((0)),
	[category_id] [int] NOT NULL CONSTRAINT [DF_tbl_master_product_category_id]  DEFAULT ((0)),
	[in_stock] [numeric](18, 4) NOT NULL CONSTRAINT [DF_tbl_master_product_in_stock]  DEFAULT ((0)),
	[price] [numeric](18, 4) NOT NULL CONSTRAINT [DF_tbl_master_product_price]  DEFAULT ((0)),
	[min_purchase_unit] [numeric](18, 4) NOT NULL CONSTRAINT [DF_tbl_master_product_min_purchase_unit]  DEFAULT ((0)),
	[enabled] [nvarchar](1) NOT NULL CONSTRAINT [DF_tbl_master_product_enabled]  DEFAULT (N'S'),
	[created_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_product_created_date]  DEFAULT (space((0))),
	[updated_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_product_updated_date]  DEFAULT (space((0))),
 CONSTRAINT [PK_tbl_master_product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[tbl_master_rate]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_rate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_master_rate](
	[rate_id] [int] NOT NULL,
	[rate] [numeric](18, 4) NOT NULL CONSTRAINT [DF_tbl_master_rate_rate]  DEFAULT ((1)),
	[rate_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_rate_rate_date]  DEFAULT (space((0))),
	[created_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_rate_created_date]  DEFAULT (space((0))),
	[updated_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_rate_updated_date]  DEFAULT (space((0))),
 CONSTRAINT [PK_tbl_master_rate] PRIMARY KEY CLUSTERED 
(
	[rate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[tbl_master_unitmeasure]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_master_unitmeasure]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_master_unitmeasure](
	[unit_measure_id] [int] NOT NULL,
	[unit_measure] [nvarchar](100) NOT NULL CONSTRAINT [DF_tbl_master_unitmeasure_unit_measure]  DEFAULT (space((0))),
	[enabled] [nvarchar](1) NOT NULL CONSTRAINT [DF_tbl_master_unitmeasure_enabled]  DEFAULT (space((0))),
	[created_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_unitmeasure_created_date]  DEFAULT (space((0))),
	[updated_date] [datetime] NOT NULL CONSTRAINT [DF_tbl_master_unitmeasure_updated_date]  DEFAULT (space((0))),
 CONSTRAINT [PK_tbl_master_unitmeasure] PRIMARY KEY CLUSTERED 
(
	[unit_measure_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[tbl_master_category] ([category_id], [category], [enabled], [created_date], [updated_date]) VALUES (1, N'Productos de Limpieza', N'S', CAST(N'2023-06-11 20:23:46.833' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_category] ([category_id], [category], [enabled], [created_date], [updated_date]) VALUES (2, N'Uso Personal', N'S', CAST(N'2023-06-14 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_category] ([category_id], [category], [enabled], [created_date], [updated_date]) VALUES (3, N'Productos Electricos', N'S', CAST(N'2023-06-14 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_category] ([category_id], [category], [enabled], [created_date], [updated_date]) VALUES (4, N'Productos de Iluminación', N'S', CAST(N'2023-06-14 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (1, N'CEPILLO LAVAR ANATOMICO', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.5000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (2, N'PALA', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(3.5000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (3, N'RASTRILLO', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (4, N'RASTRILLO', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.6000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (5, N'ESPONJAS', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.3000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (6, N'SPEED STICK (desodorante speed stick)', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.2000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (7, N'PANTENE', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.3000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (8, N'BOLSAS NEGRAS 30 KG', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.1000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (9, N'PAPEL HIGIENICO', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.9000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (10, N'CEPILLO LAVAR SIMPLE', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.3000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (11, N'CEPILLO', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(2.2000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (12, N'CLORO', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.4000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (13, N'SUAVIZANTE', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.7000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (14, N'ARIEL', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (15, N'BRISOL ', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (16, N'DESINFECTANTE', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.7000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (17, N'DESINFECTANTE ULTRA', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.7000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (18, N'DESENGRASANTE COCINA', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.8000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (19, N'CERA', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.8000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (20, N'BOMBILLO 10W', 2, 3, CAST(0.0000 AS Numeric(18, 4)), CAST(1.1000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (21, N'BOMBILLO 15W', 2, 3, CAST(0.0000 AS Numeric(18, 4)), CAST(1.4000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (22, N'ALIDENT', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(1.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (23, N'NUTRIBELA', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.5000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (24, N'VELAS', 2, 4, CAST(0.0000 AS Numeric(18, 4)), CAST(0.2000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (25, N'JABÓN DE AVENA', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.4000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (26, N'JABÓN REXONA', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(1.4000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (27, N'ESPONJAS MULTIUSO', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.3000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (28, N'PEINES', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.1000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (29, N'JABÓN DE HARMONY', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.4000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (30, N'DARCO AFEITADORAS', 2, 2, CAST(0.0000 AS Numeric(18, 4)), CAST(0.2000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (31, N'COLETOS', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (32, N'GUANTES', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.2000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (33, N'ESPONJAS KING VERDES', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.2000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (34, N'ESPONJAS JABONOSAS', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.1000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (35, N'ESPONJAS DE FREGAR AMARRILLO VERDE', 2, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(0.5000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (36, N'LIMPOTEX', 1, 1, CAST(0.0000 AS Numeric(18, 4)), CAST(1.7000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-13 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (37, N'producto de prueba 2', 2, 3, CAST(10.0000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-16 16:00:57.280' AS DateTime), CAST(N'2023-06-17 22:29:15.540' AS DateTime))
INSERT [dbo].[tbl_master_product] ([Id], [product], [unit_measure_id], [category_id], [in_stock], [price], [min_purchase_unit], [enabled], [created_date], [updated_date]) VALUES (38, N'prueba de producto', 1, 1, CAST(20.0000 AS Numeric(18, 4)), CAST(2.2000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), N'S', CAST(N'2023-06-17 10:07:13.760' AS DateTime), CAST(N'2023-06-17 22:27:23.540' AS DateTime))
INSERT [dbo].[tbl_master_rate] ([rate_id], [rate], [rate_date], [created_date], [updated_date]) VALUES (1, CAST(27.1053 AS Numeric(18, 4)), CAST(N'2023-06-14 00:00:00.000' AS DateTime), CAST(N'2023-06-14 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_rate] ([rate_id], [rate], [rate_date], [created_date], [updated_date]) VALUES (2, CAST(27.1713 AS Numeric(18, 4)), CAST(N'2023-06-15 00:00:00.000' AS DateTime), CAST(N'2023-06-15 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_rate] ([rate_id], [rate], [rate_date], [created_date], [updated_date]) VALUES (3, CAST(27.1737 AS Numeric(18, 4)), CAST(N'2023-06-16 00:00:00.000' AS DateTime), CAST(N'2023-06-16 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_rate] ([rate_id], [rate], [rate_date], [created_date], [updated_date]) VALUES (4, CAST(27.2780 AS Numeric(18, 4)), CAST(N'2023-06-17 00:00:00.000' AS DateTime), CAST(N'2023-06-17 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_rate] ([rate_id], [rate], [rate_date], [created_date], [updated_date]) VALUES (5, CAST(27.2780 AS Numeric(18, 4)), CAST(N'2023-06-18 00:00:00.000' AS DateTime), CAST(N'2023-06-18 21:38:43.483' AS DateTime), CAST(N'2023-06-18 21:39:19.510' AS DateTime))
INSERT [dbo].[tbl_master_unitmeasure] ([unit_measure_id], [unit_measure], [enabled], [created_date], [updated_date]) VALUES (1, N'Litros', N'S', CAST(N'2023-06-11 20:31:57.360' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[tbl_master_unitmeasure] ([unit_measure_id], [unit_measure], [enabled], [created_date], [updated_date]) VALUES (2, N'Unidades', N'S', CAST(N'2023-06-11 20:31:57.360' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime))
/****** Object:  StoredProcedure [dbo].[zsp_AddEditTasaCambio]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_AddEditTasaCambio]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_AddEditTasaCambio] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 18/06/2023
-- Description:	Registrar y Actualizar la tasa de cambio
-- =============================================
ALTER PROCEDURE [dbo].[zsp_AddEditTasaCambio] 
	@rate numeric(18,4),
	@rate_date datetime
AS
BEGIN
	
	declare @rate_id int

	select @rate_id = isnull(max(rate_id),0) + 1 from tbl_master_rate

	if (exists(select top 1 rate_date from tbl_master_rate where rate_date = cast(@rate_date as date)))
		update tbl_master_rate 
			set rate = @rate,
				rate_date = cast(@rate_date as date),
				updated_date = getdate()
		where rate_date = cast(@rate_date as date)
	else
		insert into tbl_master_rate
			(rate_id, rate, rate_date, created_date)
		values
			(@rate_id, @rate, cast(@rate_date as date), getdate())
END

GO
/****** Object:  StoredProcedure [dbo].[zsp_AddProduct]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_AddProduct]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_AddProduct] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 2023-06-15
-- Description:	Registrar el producto
-- =============================================
ALTER PROCEDURE [dbo].[zsp_AddProduct]
	@product nvarchar(100),
	@unit_measure_id int,
	@category_id int,
	@in_stock numeric(18,4),
	@price numeric(18,4),
	@min_purchase_unit numeric(18,4),
	@enabled nvarchar(1)
AS
BEGIN

	DECLARE @Id INT

	SELECT @Id = ISNULL(MAX(Id),0) + 1 FROM [dbo].[tbl_master_product]

	INSERT INTO [dbo].[tbl_master_product]
			   ([Id]
			   ,[product]
			   ,[unit_measure_id]
			   ,[category_id]
			   ,[in_stock]
			   ,[price]
			   ,[min_purchase_unit]
			   ,[enabled]
			   ,[created_date])
		 VALUES
			   (@Id,
				@product,
				@unit_measure_id,
				@category_id,
				@in_stock,
				@price,
				@min_purchase_unit,
				@enabled,
				GETDATE())
END

GO
/****** Object:  StoredProcedure [dbo].[zsp_EditProduct]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_EditProduct]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_EditProduct] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 2023-06-15
-- Description:	Registrar el producto
-- =============================================
ALTER PROCEDURE [dbo].[zsp_EditProduct]
	@id int,
	@product nvarchar(100),
	@unit_measure_id int,
	@category_id int,
	@in_stock numeric(18,4),
	@price numeric(18,4),
	@min_purchase_unit numeric(18,4),
	@enabled nvarchar(1)
AS
BEGIN
	UPDATE [dbo].[tbl_master_product]
	   SET [product] = @product
		  ,[unit_measure_id] = @unit_measure_id
		  ,[category_id] = @category_id
		  ,[in_stock] = @in_stock
		  ,[price] = @price
		  ,[min_purchase_unit] = @min_purchase_unit
		  ,[enabled] = @enabled
		  ,[updated_date] = GETDATE()
	 WHERE [Id] = @id
END

GO
/****** Object:  StoredProcedure [dbo].[zsp_ListCategory]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_ListCategory] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 2023-06-13
-- Description:	Listado de categorias
-- =============================================
ALTER PROCEDURE [dbo].[zsp_ListCategory] 
	@pcode_error nvarchar(12) output
	,@pmessages NVARCHAR(250) output
AS
BEGIN
	begin try
		select category_id,
			category,
			[enabled],
			created_date,
			updated_date
		from tbl_master_category
		where [enabled] = 'S'
		order by category
	end try
	begin catch
		set @pcode_error = cast(error_number() as nvarchar(12))
		set @pmessages = error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[zsp_ListInventoryProducts]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListInventoryProducts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_ListInventoryProducts] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 11/06/2023
-- Description:	Listado de productos en inventarios
-- =============================================
ALTER PROCEDURE [dbo].[zsp_ListInventoryProducts]
	@pcode_error nvarchar(12) output
	,@pmessages NVARCHAR(250) output
AS
BEGIN

	begin try
		select t0.id as Item,
			t0.product as Producto,
			t2.category as Categoria,
			t0.in_stock as EnInventario,
			t1.unit_measure as Unidad,
			t0.price as Precio,
			[dbo].[zfn_GetCurrentRate](getdate()) as rate,
			(t0.price * [dbo].[zfn_GetCurrentRate](getdate())) as precio_bs,
			t0.min_purchase_unit as CantidadReposicion,
			case
				when t0.in_stock <= t0.min_purchase_unit then 'Debe reponer el inventario' else ''
			end as Observaciones,
			case
				when t0.[enabled] = 'S' then 'Sí'
				else 'No'
			end as Habilitado,
			t0.created_date as FechaRegistro,
			t0.updated_date as FechaModificacion,
			t0.unit_measure_id as IdUnidadMedida,
			t0.category_id as IdCategoria
		from tbl_master_product as t0
			inner join tbl_master_unitmeasure as t1 on t0.unit_measure_id = t1.unit_measure_id
			inner join tbl_master_category as t2 on t0.category_id = t2.category_id
		order by t0.id
	end try
	begin catch
		set @pcode_error = cast(error_number() as nvarchar(12))
		set @pmessages = error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[zsp_ListRate]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListRate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_ListRate] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 2023-06-15
-- Description:	Listado de las tasas de cambio
-- =============================================
ALTER PROCEDURE [dbo].[zsp_ListRate] 
	@pcode_error nvarchar(12) output
	,@pmessages NVARCHAR(250) output
AS
BEGIN
	begin try
		select rate_id
			  ,rate
			  ,rate_date
			  ,created_date
			  ,updated_date
		  from tbl_master_rate
		  order by rate_date desc
	end try
	begin catch
		set @pcode_error = cast(error_number() as nvarchar(12))
		set @pmessages = error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[zsp_ListUnitMeasure]    Script Date: 21/06/2023 05:30:35 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zsp_ListUnitMeasure]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[zsp_ListUnitMeasure] AS' 
END
GO
-- =============================================
-- Author:		Pablo Aponte
-- Create date: 2023-06-15
-- Description:	Listado de las unidades de medida
-- =============================================
ALTER PROCEDURE [dbo].[zsp_ListUnitMeasure]
	@pcode_error nvarchar(12) output
	,@pmessages NVARCHAR(250) output
AS
BEGIN
	begin try
		select unit_measure_id
		  ,unit_measure
		  ,case when [enabled] = 'S' then 'Sí' else 'No' end as [Enable]
		  ,created_date
		  ,updated_date
	  from tbl_master_unitmeasure
	  where [enabled] = 'S'
  end try
  begin catch
		set @pcode_error = cast(error_number() as nvarchar(12))
		set @pmessages = error_message()
  end catch
END

GO
