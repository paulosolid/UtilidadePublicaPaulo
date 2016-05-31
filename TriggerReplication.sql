/* Essa Trigger Insere um registro Deletado para outra tabela!
Caso um dia queira rever Registros Excluídos
- Primeiro Passo: Criamos a Trigger
- Segundo Passo: Criamos a tabela onde aplicaremos a Trigger
- Terceiro Passo: Criamos a tabela onde a trigger fará o insert dos registros deletados
- Quarto Passo: Iremos fazer um teste, excluindo dois registros e vericamos se a Trigger está Funcionando.
 
Nota: Executem cada passo de uma vez para fazer o teste da Trigger
*/
 
---------------------------
---------------------------
-- Primeiro Passo----------
---------------------------
---------------------------
---------------------------
 
USE [msdb]
GO
 
/****** Object:  Trigger [dbo].[Trigger_JEDI]    Script Date: 09/05/2013 23:53:51 ******/
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
Create Trigger [dbo].[Trigger_JEDI] On [dbo].[Cliente]
After Delete
As
begin
  insert into [exclCliente]
    (Id, Nome, Telefone, dataexcl)  
    (select *, GetDate() from deleted);
end
 
 
 
GO
 
---------------------------
---------------------------
-- Segundo Passo-----------
---------------------------
---------------------------
 
USE [msdb]
GO
 
/****** Object:  Table [dbo].[Cliente]    Script Date: 10/05/2013 00:07:59 ******/
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
SET ANSI_PADDING ON
GO
 
CREATE TABLE [dbo].[Cliente](
        [Id] [char](2) NOT NULL,
        [Nome] [varchar](50) NOT NULL,
        [Telefone] [nvarchar](12) NULL,
PRIMARY KEY CLUSTERED
(
        [Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
------------------------------
------------------------------
-- Inserir Registros na Tabela
------------------------------
------------------------------
 
insert into [dbo].[cliente]  values  (1 ,'Diego Tardelli',      '3132112345')
insert into [dbo].[cliente]  values (2,'Ronaldinho Gaúcho',    '3132113141')
insert into [dbo].[cliente]  values (3,'Bernard Ben10', '3132113123')
insert into [dbo].[cliente]  values (5,'Jô','3132113121')
 
----------------------------
----------------------------
-- Terceiro Passo-----------
----------------------------
----------------------------
 
USE [msdb]
GO
 
/****** Object:  Table [dbo].[exclCliente]    Script Date: 10/05/2013 00:09:23 ******/
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
SET ANSI_PADDING ON
GO
 
CREATE TABLE [dbo].[exclCliente](
        [Id] [char](2) NOT NULL,
        [Nome] [varchar](50) NOT NULL,
        [Telefone] [nvarchar](12) NULL,
        [dataexcl] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
        [Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
 
 
-----------------------------------------
-----------------------------------------
-------Quarto Passo - Grand Finale-------
-----------------------------------------
-----------------------------------------
 
Delete From Cliente where Id in (1,2)
 
----------- Verificar Registros na tabela dos registros Inseridos
 
 
Select * from exclCliente with (nolock) -- =D