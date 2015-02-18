SELECT TOP 10
    total_worker_time/execution_count AS Avg_CPU_Time
        ,execution_count
        ,total_elapsed_time/execution_count as AVG_Run_Time
        ,(SELECT
              SUBSTRING(text,statement_start_offset/2,(CASE
                                                           WHEN statement_end_offset = -1 THEN LEN(CONVERT(nvarchar(max), text)) * 2 
                                                           ELSE statement_end_offset 
                                                       END -statement_start_offset)/2
                       ) FROM sys.dm_exec_sql_text(sql_handle)
         ) AS query_text 
FROM sys.dm_exec_query_stats 

--pick your criteria

ORDER BY Avg_CPU_Time DESC
--ORDER BY AVG_Run_Time DESC
--ORDER BY execution_count DESC




SELECT TOP 50 * FROM(SELECT COALESCE(OBJECT_NAME(s2.objectid),'Ad-Hoc') AS ProcName,
  execution_count,s2.objectid,
    (SELECT TOP 1 SUBSTRING(s2.TEXT,statement_start_offset / 2+1 ,
      ( (CASE WHEN statement_end_offset = -1
  THEN (LEN(CONVERT(NVARCHAR(MAX),s2.TEXT)) * 2)
ELSE statement_end_offset END)- statement_start_offset) / 2+1)) AS sql_statement,
       last_execution_time
FROM sys.dm_exec_query_stats AS s1
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 ) x
WHERE sql_statement NOT like 'SELECT * FROM(SELECT coalesce(object_name(s2.objectid)%'
and OBJECTPROPERTYEX(x.objectid,'IsProcedure') = 1
and exists (SELECT 1 FROM sys.procedures s
WHERE s.is_ms_shipped = 0
and s.name = x.ProcName )
ORDER BY execution_count DESC




SELECT TOP 10 SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
((CASE qs.statement_end_offset
WHEN -1 THEN DATALENGTH(qt.TEXT)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2)+1),
qs.execution_count,
qs.total_logical_reads, qs.last_logical_reads,
qs.total_logical_writes, qs.last_logical_writes,
qs.total_worker_time,
qs.last_worker_time,
qs.total_elapsed_time/1000000 total_elapsed_time_in_S,
qs.last_elapsed_time/1000000 last_elapsed_time_in_S,
qs.last_execution_time,
qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY qs.total_logical_reads DESC -- logical reads
-- ORDER BY qs.total_logical_writes DESC -- logical writes
-- ORDER BY qs.total_worker_time DESC -- CPU time











SELECT TOP 50 * FROM(SELECT COALESCE(OBJECT_NAME(s2.objectid),'Ad-Hoc') AS ProcName,
  execution_count,s2.objectid,
    (SELECT TOP 1 SUBSTRING(s2.TEXT,statement_start_offset / 2+1 ,
      ( (CASE WHEN statement_end_offset = -1
  THEN (LEN(CONVERT(NVARCHAR(MAX),s2.TEXT)) * 2)
ELSE statement_end_offset END)- statement_start_offset) / 2+1)) AS sql_statement,
       last_execution_time
FROM sys.dm_exec_query_stats AS s1
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 ) x
WHERE sql_statement NOT like 'SELECT * FROM(SELECT coalesce(object_name(s2.objectid)%'
and OBJECTPROPERTYEX(x.objectid,'IsProcedure') = 1
and exists (SELECT 1 FROM sys.procedures s
WHERE s.is_ms_shipped = 0
and s.name = x.ProcName )
ORDER BY execution_count DESC

--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////
-- http://blogs.msdn.com/b/sqlsecurity/archive/2008/12/12/how-to-create-a-sql-trace-without-using-sql-profiler.aspx
--///////////////////////////////////////////////////////////////////////////////////////////////////////



-- sys.traces shows the existing sql traces on the server
select * from sys.traces
go
 
--create a new trace, make sure the @tracefile must NOT exist on the disk yet
declare @tracefile nvarchar(500) set @tracefile=N'c:\temp\newtraceFile'
declare @trace_id int
declare @maxsize bigint
set @maxsize =1
exec sp_trace_create @trace_id output,2,@tracefile ,@maxsize
go
 
--- add the events of insterest to be traced, and add the result columns of interest
--  Note: look up in sys.traces to find the @trace_id, here assuming this is the first trace in the server, therefor @trace_id=1
declare @trace_id int
set @trace_id=1
declare @on bit
set @on=1
declare @current_num int
set @current_num =1
while(@current_num <65)
      begin
      --add events to be traced, id 14 is the login event, you add other events per your own requirements, the event id can be found @ BOL http://msdn.microsoft.com/en-us/library/ms186265.aspx
      exec sp_trace_setevent @trace_id,14, @current_num,@on
      set @current_num=@current_num+1
      end
go
 
--turn on the trace: status=1
-- use sys.traces to find the @trace_id, here assuming this is the first trace in the server, so @trace_id=1
declare @trace_id int
set @trace_id=1
exec sp_trace_setstatus  @trace_id,1
 
--pivot the traced event
select LoginName,DatabaseName,* from ::fn_trace_gettable(N'c:\temp\newtraceFile.trc',default)
go
 
-- stop trace. Please manually delete the trace file on the disk
-- use sys.traces to find the @trace_id, here assuming this is the first trace in the server, so @trace_id=1
declare @trace_id int
set @trace_id=1
exec sp_trace_setstatus @trace_id,0
exec sp_trace_setstatus @trace_id,2
go