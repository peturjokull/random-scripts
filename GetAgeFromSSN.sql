USE [PlayGround]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [date].[GetAgeFromSSN]
(
    @kt varchar(100)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
--https://is.wikipedia.org/wiki/Kennitala
declare @sSum int;
select @sSum = (	
	SELECT (3 * SUBSTRING(@kt,1,1)) +
		   (2 * SUBSTRING(@kt,2,1)) +
		   (7 * SUBSTRING(@kt,3,1)) +
		   (6 * SUBSTRING(@kt,4,1)) +
		   (5 * SUBSTRING(@kt,5,1)) +
		   (4 * SUBSTRING(@kt,6,1)) +
		   (3 * SUBSTRING(@kt,7,1)) +
		   (2 * SUBSTRING(@kt,8,1)) ) 
		

declare @modRes int = (SELECT @sSum % 11);
declare @BD varchar(8) = substring(@kt,5,2)
declare @decade varchar(1) =  SUBSTRING(@kt,10,1)


	IF @modRes > 0
		BEGIN
			SET @modRes = 11 - @modRes;
		END
	IF (@modRes != SUBSTRING(@KT,9,1))
		BEGIN
			return cast('Þetta er ekki gild kennitala.' as int);
		END
	IF (@decade not in ('0','8','9'))
		BEGIN
			return cast('Ekki gild öld' as int);
		END
	IF (LEN(@kt) != 10)
		BEGIN
			return cast('Þetta er ekki gild kennitala. Skoðaðu lengdina á kennitölunni - ['+@kt+']' as int);
		END


if @decade = '9' 
	begin 
		set @BD = '19'+@BD +  SUBSTRING(@KT,3,2) + SUBSTRING(@KT,1,2)
	end
else if @decade = '0'
	begin
		set @BD = '20'+@BD
	end

	RETURN DATEDIFF(DAY,CONVERT(DATE,@BD),GETDATE())/365.25

END
