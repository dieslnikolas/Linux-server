/* Zaloha nesystemovych databazi */
create table #databases (Name varchar(255), Size int, REMARKS varchar(255))

insert into #databases
execute sp_databases

declare @Name varchar(255)
declare @Date nvarchar(max) = FORMAT(getutcdate(), 'd', 'de-de')
declare c cursor local for
select Name from #databases where not Name in ('master', 'model', 'msdb', 'tempdb')
open c
fetch next from c into @Name
while @@FETCH_STATUS = 0
begin
	declare @sql varchar(255)
	set @sql = 'BACKUP DATABASE ['+@Name+'] TO  DISK = ''/backups/sqldb/' + @Date + '/' +@Name+'.bak'' WITH INIT'
	exec(@sql)
	fetch next from c into @Name
end
close c
deallocate c

drop table #databases
