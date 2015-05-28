


CREATE PROCEDURE BD_TX_Campos 

(
				 @table_name		nvarchar(384),
				 @table_owner		nvarchar(384) = null,
				 @table_qualifier	sysname = null,
				 @column_name		nvarchar(384) = null,
				 @ODBCVer			int = 2)
AS

    DECLARE @full_table_name	nvarchar(769)
    DECLARE @table_id int
	if @ODBCVer <> 3
		select @ODBCVer = 2
	if @column_name is null /*	If column name not supplied, match all */
		select @column_name = '%'
	if @table_qualifier is not null
    begin
		if db_name() <> @table_qualifier
		begin	/* If qualifier doesn't match current database */
			raiserror (15250, -1,-1)
			return
		end
    end
	if @table_name is null
	begin	/*	If table name not supplied, match all */
		select @table_name = '%'
	end
	if @table_owner is null
	begin	/* If unqualified table name */
		SELECT @full_table_name = quotename(@table_name)
    end
    else
	begin	/* Qualified table name */
		if @table_owner = ''
		begin	/* If empty owner name */
			SELECT @full_table_name = quotename(@table_owner)
		end
		else
		begin
			SELECT @full_table_name = quotename(@table_owner) +
				'.' + quotename(@table_name)
		end
    end
	/*	Get Object ID */
	SELECT @table_id = object_id(@full_table_name)
	if ((isnull(charindex('%', @full_table_name),0) = 0) and
		(isnull(charindex('[', @table_name),0) = 0) and
		(isnull(charindex('[', @table_owner),0) = 0) and
		(isnull(charindex('_', @full_table_name),0) = 0) and
		@table_id <> 0)
    begin
		/* this block is for the case where there is no pattern
			matching required for the table name */
		SELECT
			TABLE_QUALIFIER = convert(sysname,DB_NAME()),
			TABLE_OWNER = convert(sysname,USER_NAME(o.uid)),
			TABLE_NAME = convert(sysname,o.name),
			COLUMN_NAME = convert(sysname,c.name)
		FROM
			sysobjects o,
			systypes t,
			syscolumns c
			LEFT OUTER JOIN syscomments m on c.cdefault = m.id
				AND m.colid = 1
		WHERE
			o.id = @table_id
			AND c.id = o.id
			AND o.type <> 'P'
			AND c.xusertype = t.xusertype
			AND c.name like @column_name
		ORDER BY COLUMN_NAME
	end
	else
    begin
		/* this block is for the case where there IS pattern
			matching done on the table name */
		if @table_owner is null /*	If owner not supplied, match all */
			select @table_owner = '%'
		SELECT
			TABLE_QUALIFIER = convert(sysname,DB_NAME()),
			TABLE_OWNER = convert(sysname,USER_NAME(o.uid)),
			TABLE_NAME = convert(sysname,o.name),
			COLUMN_NAME = convert(sysname,c.name)
		FROM
			sysobjects o,
			systypes t,
			syscolumns c
			LEFT OUTER JOIN syscomments m on c.cdefault = m.id
				AND m.colid = 1
		WHERE
			o.name like @table_name
			AND user_name(o.uid) like @table_owner
			AND o.id = c.id
			AND o.type <> 'P'
			AND c.xusertype = t.xusertype
			AND c.name like @column_name
		ORDER BY COLUMN_NAME
	end



