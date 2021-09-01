SELECT location, population, date, total_cases, new_cases, total_deaths
FROM CovidProject..DeathsCovid$
order by total_deaths desc


-- Looking for the percentage of deaths from the total cases  
SELECT location,  total_cases,  total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidProject..DeathsCovid$ where location like '%nigeria%'
order by 4 desc 


-- change total_deaths to numeric data type to perform sum/ aggregated calculation
alter table CovidProject..DeathsCovid$ alter column total_deaths int
alter table covidproject..deathsCovid$ alter column total_cases int

select cast(new_deaths as int) from CovidProject..DeathsCovid$

-- total deaths in each location/country
SELECT location, sum(total_deaths)
FROM CovidProject..DeathsCovid$
where continent is not null --asia is sometimes refered to as a location and not a continent
group by location
order by location

--deaths per total cases in each country
--ERROR
select location, sum(total_deaths)/sum(total_cases)
from CovidProject..DeathsCovid$
group by location


--SELECT * FROM CovidProject..VaccinationsCovid$

select total_deaths
from CovidProject..DeathsCovid$



--Total cases vs Population
select (total_cases/population)* 100 as InfectedPopulation
from CovidProject..DeathsCovid$

--countries with highest infection rate compared to population
select location, max(total_cases) as cases , max((total_cases/population))* 100 as "Infected Population"
from CovidProject..DeathsCovid$
group by location 
order by [Infected Population] desc

--countries with the highest death percentage per population
select location, population,  max((total_deaths/population))*100 as deathPercentage from CovidProject..DeathsCovid$ 
group by location, population
order by 3 desc

select location, population, new_deaths, total_deaths from CovidProject..DeathsCovid$

--select isnull(continent, 'Other') as continent
select continent, max(population) as population, max(total_deaths), max((total_deaths/population))*100 as total_deaths  from CovidProject..DeathsCovid$ 
where continent is not null
group by continent 
order by max(total_deaths) desc



-- Total Vaccination by population
select d.location, d.population, max(v.total_vaccinations) as totalVax
from CovidProject..DeathsCovid$  d
inner join 
 CovidProject..VaccinationsCovid$  v
 on d.location = v.location
 and d.date = v.date
 group by d.location, d.population
 order by 3 desc

With PopVsVac ( location, population, total_vaccinations )
as (
select d.location, d.population, max(v.total_vaccinations) as totalVax
from CovidProject..DeathsCovid$  d
inner join 
 CovidProject..VaccinationsCovid$  v
 on d.location = v.location
 and d.date = v.date
 group by d.location, d.population
 --order by 3 desc
 )
 select * from PopVsVac

 --how many people in each location is vaccinated using cte and new_vaccination


 --
 create table #percentpopulationVaccinated

