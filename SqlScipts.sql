GO
/****** Object:  Table [dbo].[ShortUrl]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShortUrl](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LongUrl] [nvarchar](max) NULL,
	[Segment] [nvarchar](max) NULL,
	[Added] [datetime2](7) NULL,
	[Ip] [nvarchar](max) NULL,
	[NumOfClicks] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[delete_All_Rows_In_ShortUrl]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[delete_All_Rows_In_ShortUrl]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Delete statements for procedure here	
	DELETE FROM [dbo].[ShortUrl]
END


-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[delete_ShortUrl_By_LongUrl]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[delete_ShortUrl_By_LongUrl]
	-- Add the parameters for the stored procedure here
	(@LongUrl nvarchar(max))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Delete statements for procedure here	
	DELETE FROM [dbo].[ShortUrl] WHERE [LongUrl] = @LongUrl
END


-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[delete_ShortUrl_By_Segment]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[delete_ShortUrl_By_Segment]
	-- Add the parameters for the stored procedure here
	(@Segment nvarchar(max))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Delete statements for procedure here	
	DELETE FROM [dbo].[ShortUrl] WHERE [Segment] = @Segment
END


-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[get_OneShortUrl_By_LongUrl]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[get_OneShortUrl_By_LongUrl]
	-- Add the parameters for the stored procedure here
	(@LongUrl nvarchar(max))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 * from [dbo].[ShortUrl]
	where [LongUrl] = @LongUrl
END

GO
/****** Object:  StoredProcedure [dbo].[get_OneShortUrl_By_Segment]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_OneShortUrl_By_Segment]
	-- Add the parameters for the stored procedure here
	(@Segment nvarchar(max))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 * from [dbo].[ShortUrl]
	where [Segment] = @Segment
END

GO
/****** Object:  StoredProcedure [dbo].[get_ShortUrl_By_Segment]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_ShortUrl_By_Segment]
	-- Add the parameters for the stored procedure here
	(@Segment nvarchar(max))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from [dbo].[ShortUrl]
	where [Segment] = @Segment
END


-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[insert_In_ShortUrl]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insert_In_ShortUrl]
	-- Add the parameters for the stored procedure here
	(@LongUrl nvarchar(max), 
	 @Segment nvarchar(max), 
	 @Added datetime2(7), 
	 @Ip nvarchar(max), 
	 @NumOfClicks INTEGER)
AS
BEGIN
	
	insert into [dbo].[ShortUrl] (LongUrl, Segment, Added, Ip, NumOfClicks) values(@LongUrl, @Segment, @Added, @Ip, @NumOfClicks)
    
END

GO
/****** Object:  StoredProcedure [dbo].[update_In_ShortUrl]    Script Date: 11/17/2017 9:01:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[update_In_ShortUrl]
	-- Add the parameters for the stored procedure here
	(@Segment nvarchar(max), 	 
	 @NumOfClicks INTEGER)
AS
BEGIN
	
	update [dbo].[ShortUrl]
	set [NumOfClicks] = @NumOfClicks
    where [Segment] = @Segment
END

GO
