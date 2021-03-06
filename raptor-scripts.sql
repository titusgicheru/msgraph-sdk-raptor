USE [Raptor]
GO
/****** Object:  Table [dbo].[CompileResult]    Script Date: 8/8/2019 8:35:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompileResult](
	[CompileResultsID] [uniqueidentifier] NOT NULL,
	[CompileCycleID] [uniqueidentifier] NOT NULL,
	[IsSuccess] [bit] NOT NULL,
	[FileName] [varchar](max) NOT NULL,
	[Snippet] [varchar](max) NOT NULL,
 CONSTRAINT [PK_CompileResults] PRIMARY KEY CLUSTERED 
(
	[CompileResultsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompileResultsError]    Script Date: 8/8/2019 8:35:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompileResultsError](
	[CompileResultsErrorID] [uniqueidentifier] NOT NULL,
	[CompileResultsID] [uniqueidentifier] NOT NULL,
	[ErrorCode] [nchar](20) NULL,
	[IsWarning] [bit] NULL,
	[WarningLevel] [int] NULL,
	[ErrorMessage] [varchar](max) NULL,
 CONSTRAINT [PK_CompileResultsErrors] PRIMARY KEY CLUSTERED 
(
	[CompileResultsErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompileCycle]    Script Date: 8/8/2019 8:35:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompileCycle](
	[CompileCycleID] [uniqueidentifier] NOT NULL,
	[TotalCompiledSnippets] [int] NOT NULL,
	[TotalSnippetsWithError] [int] NOT NULL,
	[TotalErrors] [int] NOT NULL,
	[Language] [int] NOT NULL,
	[Version] [int] NULL,
	[ExecutionTime] [decimal](18, 2) NULL,
	[CompileDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CompileCycles] PRIMARY KEY CLUSTERED 
(
	[CompileCycleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CompileResultsView]    Script Date: 8/8/2019 8:35:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CompileResultsView]
AS
SELECT        dbo.CompileResult.CompileResultsID, dbo.CompileCycle.CompileCycleID, dbo.CompileCycle.Language, dbo.CompileCycle.Version, dbo.CompileResult.IsSuccess, dbo.CompileResult.FileName, 
                         dbo.CompileResultsError.CompileResultsErrorID, dbo.CompileResultsError.ErrorMessage, dbo.CompileCycle.CompileDate, dbo.CompileResult.Snippet
FROM            dbo.CompileCycle INNER JOIN
                         dbo.CompileResult ON dbo.CompileCycle.CompileCycleID = dbo.CompileResult.CompileCycleID INNER JOIN
                         dbo.CompileResultsError ON dbo.CompileResult.CompileResultsID = dbo.CompileResultsError.CompileResultsID
WHERE        (dbo.CompileCycle.CompileDate =
                             (SELECT        MAX(CompileDate) AS Expr1
                               FROM            dbo.CompileCycle AS CompileCycle_1))
GO
/****** Object:  View [dbo].[CompileCycleView]    Script Date: 8/8/2019 8:35:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CompileCycleView]
AS
SELECT        CompileCycleID, TotalCompiledSnippets, TotalSnippetsWithError, TotalErrors, Language, Version, ExecutionTime, CompileDate
FROM            dbo.CompileCycle
GO
ALTER TABLE [dbo].[CompileCycle] ADD  CONSTRAINT [DF_CompileCycles_CompileDate]  DEFAULT (getdate()) FOR [CompileDate]
GO
ALTER TABLE [dbo].[CompileResult]  WITH CHECK ADD  CONSTRAINT [FK_CompileResults_CompileCycles] FOREIGN KEY([CompileCycleID])
REFERENCES [dbo].[CompileCycle] ([CompileCycleID])
GO
ALTER TABLE [dbo].[CompileResult] CHECK CONSTRAINT [FK_CompileResults_CompileCycles]
GO
ALTER TABLE [dbo].[CompileResultsError]  WITH CHECK ADD  CONSTRAINT [FK_CompileResultsErrors_CompileResults] FOREIGN KEY([CompileResultsID])
REFERENCES [dbo].[CompileResult] ([CompileResultsID])
GO
ALTER TABLE [dbo].[CompileResultsError] CHECK CONSTRAINT [FK_CompileResultsErrors_CompileResults]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CompileCycle"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 279
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2070
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompileCycleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompileCycleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[16] 4[35] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CompileCycle"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 243
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CompileResult"
            Begin Extent = 
               Top = 6
               Left = 289
               Bottom = 231
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CompileResultsError"
            Begin Extent = 
               Top = 6
               Left = 509
               Bottom = 214
               Right = 716
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 3420
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3675
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompileResultsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompileResultsView'
GO
