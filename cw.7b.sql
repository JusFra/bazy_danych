
GO
CREATE PROCEDURE fibon
	@n INT
AS
	DECLARE @a INT
	DECLARE @b INT
	DECLARE @c INT
	DECLARE @i INT

	SET @a=1
	SET @b=1
	SET @i=0
	SET @c=0

	PRINT 'Ci¹g Fibonacciego'
	PRINT @a
	PRINT @b
	WHILE @i<@n-2
	Begin
		SET @c=@a+@b
		PRINT @c
		SET @i=@i+1
		SET @a=@b
		SET @b=@c
	END
GO

EXEC fibon 10;
