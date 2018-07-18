CREATE TABLE [dbo].[Usuarios] (
    [Nombre]   NVARCHAR (400) NOT NULL,
    [Cargo]    NVARCHAR (MAX) NOT NULL,
    [Password] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Nombre] ASC)
);

