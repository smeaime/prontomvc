
create FUNCTION [dbo].convertInt (@value VARCHAR(50)) --(@value varchar(max))
RETURNS  int --varchar(max)
AS
BEGIN

    RETURN CASE isnumeric(dbo.FirstWord(@value))
        WHEN 0 THEN cast(dbo.FirstWord(@value) as int)
        ELSE 0		END
END
