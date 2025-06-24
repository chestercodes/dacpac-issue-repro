# dacpac-issue-repro
a repo to describe an issue i'm having with dacpacs

## issue

when adding a column to a table, permissions which were previously added to that table by another process are removed

the table is recreated because the create table statement changes from

``` sql
CREATE TABLE [Table2] (
    [Id]            UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [Col1]        NVARCHAR (25)    NOT NULL
);
```

to

``` sql
CREATE TABLE [Table2] (
    [Id]            UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [BeforeCol1]        NVARCHAR (25)    NOT NULL,
    [Col1]        NVARCHAR (25)    NOT NULL
);
```

the column being added to the middle of the table forces a table recreate and when this happens, any existing permissions which were on the table are not added to the recreated table


## steps to take

spin up the sql server in the docker compose file with the command:

``` pwsh
docker compose up
```

logon to the server and create the database with the script `01-add-db.sql`

load up the State1.sln and then right click on the publish xml file to create the tables in the database

run the sql in the script 03-add-user.sql to add permissions to the tables

run the sql in the script 04-show-permissions.sql to show that INSERT, SELECT, UPDATE and DELETE permissions are present on each table

load up the State2.sln and then right click on the publish xml file to add the column to Table2, this will recreate the table

run the sql in the script 04-show-permissions.sql to show that INSERT, SELECT, UPDATE and DELETE permissions are no longer present on the recreated Table2