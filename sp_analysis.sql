CREATE PROCEDURE sp_main_analysis_1
--drop procedure sp_main_analysis_1
@Mjnms MajorNamesListType READONLY , @disp_mj varchar(100)
AS
BEGIN

	SET NOCOUNT ON;

	SET ARITHABORT OFF;
	SET ANSI_WARNINGS OFF;

	DROP TABLE IF EXISTS #temp
--	DROP TABLE IF EXISTS #temp1

	select * into #temp
	from Engage_Data
	where "Major Names" in (select mj_nm_list from @Mjnms) or "Major Names" like ('"'+ @disp_mj + ',%') --or "Major Names" = '@disp_mj'

--	UPDATE #temp SET [School Year]='NA' where [School Year]='N/A'

	--------------------------------------------------------Variable Declarations---------------------------------------------------------

	DECLARE @op_f as float
	declare @clk_f as float
	declare @op_so as float
	declare @clk_so as float
	declare @op_j as float
	declare @clk_j as float
	declare @op_se as float
	declare @clk_se as float
	declare @op_m as float
	declare @clk_m as float
	declare @op_do as float
	declare @clk_do as float
	declare @op_al as float
	declare @clk_al as float
	declare @op_na as float
	declare @clk_na as float
	declare @op as float
	declare @clk as float
	declare @tot_st as int
	declare @tot_f as int
	declare @tot_so as int
	declare @tot_j as int
	declare @tot_se as int
	declare @tot_m as int
	declare @tot_al as int
	declare @tot_do as int
	declare @tot_na as int
	
	------------------------------------------------------Calculating values for respective years------------------------------------------
	
	--Overall
	select @tot_st = count(*) from #temp
--	set @op = ((select count(*) from #temp where "Opened" = 'Y')/@tot_st)*100
	select @op = count(*) from #temp where "Opened" = 'Y'
	select @clk = count(*) from #temp where "Clicked" = 'Y' 
--	set @clk = ((select count(*) from #temp where "Clicked" = 'Y')/(@op * @tot_st /100))*100

	--Freshmen
	DROP TABLE IF EXISTS  #tempf
	select * into #tempf from #temp where "School Year" = 'Freshman'
	select @tot_f = count(*) from #tempf
	select @op_f = count(*) from #tempf where "Opened" = 'Y'
	select @clk_f = count(*) from #tempf where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempf

	
	--Sophomore
	select * into #tempso from #temp where "School Year" = 'Sophomore'
	select @tot_so = count(*) from #tempso
	select @op_so = count(*) from #tempso where "Opened" = 'Y'
	select @clk_so = count(*) from #tempso where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempso
	
	--Junior
	select * into #tempj from #temp where "School Year" = 'Junior'
	select @tot_j = count(*) from #tempj
	select @op_j = count(*) from #tempj where "Opened" = 'Y'
	select @clk_j = count(*) from #tempj where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempj
	
	--Senior
	select * into #tempse from #temp where "School Year" = 'Senior'
	select @tot_se = count(*) from #tempse
	select @op_se = count(*) from #tempse where "Opened" = 'Y'
	select @clk_se = count(*) from #tempse where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempse
	
	--Masters
	select * into #tempm from #temp where "School Year" = 'Masters'
	select @tot_m = count(*) from #tempm
	select @op_m = count(*) from #tempm where "Opened" = 'Y'
	select @clk_m = count(*) from #tempm where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempm
	
	--Doctorate
	select * into #tempdo from #temp where "School Year" = 'Doctorate'
	select @tot_do = count(*) from #tempdo
	select @op_do = count(*) from #tempdo where "Opened" = 'Y'
	select @clk_do = count(*) from #tempdo where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempdo
	
	--Alumni
	select * into #tempal from #temp where "School Year" = 'Alumni'
	select @tot_al = count(*) from #tempal
	select @op_al = count(*) from #tempal where "Opened" = 'Y'
	select @clk_al = count(*) from #tempal where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempal
	
	--NA
	select * into #tempna from #temp where "School Year" = 'N/A'
	select @tot_na = count(*) from #tempna
	select @op_na = count(*) from #tempna where "Opened" = 'Y'
	select @clk_na = count(*) from #tempna where "Clicked" = 'Y' 
	DROP TABLE IF EXISTS  #tempna

	-------------------------------------------------------------------------------------------------------------------------------------

	DROP TABLE IF EXISTS  #temp

	-------------------------------------------------------------------------------------------------------------------------------------

	INSERT into Analysis_Week2 values(@disp_mj,
	@tot_st,@tot_f,@tot_so,@tot_j,@tot_se,@tot_m,@tot_al,@tot_do,@tot_na,
	(@op/@tot_st * 100),(@clk/@op * 100),(@op_f/@tot_f * 100),(@clk_f/@op_f * 100),(@op_so/@tot_so * 100),(@clk_so/@op_so * 100),(@op_j/@tot_j * 100),(@clk_j/@op_j * 100),(@op_se/@tot_se * 100),(@clk_se/@op_se * 100),
	(@op_m/@tot_m * 100),(@clk_m/@op_m * 100),(@op_do/@tot_do * 100),(@clk_do/@op_do * 100),(@op_al/@tot_al * 100),(@clk_al/@op_al * 100),(@op_na/@tot_na * 100),(@clk_na/@op_na * 100))

END