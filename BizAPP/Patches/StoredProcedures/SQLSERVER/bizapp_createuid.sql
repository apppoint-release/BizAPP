CREATE PROCEDURE bizapp_createuid
	@count int,
	@name nvarchar(20),
	@tid int
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	SET NOCOUNT ON;
	
	BEGIN TRAN
	
	declare @id int, @site nvarchar(50)
	
	-- update the id and then select the final value.
	update [ent_systemproperties] WITH (HOLDLOCK, ROWLOCK) set integervalue = integervalue + @count where [name] = @name and tid = @tid
	
	SELECT @id = integervalue - @count + 1 FROM [ent_systemproperties] WHERE [name] = @name and tid = @tid
	SELECT @id

	COMMIT TRAN

END

