# Api Docs

## Database.health_check
    returns: nill

    takes no arguments and makes sure that data folder and files
    exist or else creates them and reads data.

    must be called on VimEnter event.

## Database.add_project
    arguments:
        - name:str = project name
        - directory:str = absolute directory to project folder
        - tags: table[str, str] = List of string tags
    
    returns: nill | error

    Creates a project if it already does not exists or else it
    will throw an error

## Database.get_project
    arguments:
        - name: str

    returns: table[str, str|table[str]]

    Returns data of a project with exact name given
    works faster than search_projects.

## Database.search_projects
    arguments:
        -query: table[str, str|table[str]] = tages query mode as keys
            and search text as value
    returns: table[str,table[str,str]] = list of seaches and distances
    
    Takes query and fuzzy searches in projects


# Schema

## Project
```json
{
        name:{
            tags: [int,...],
            project_dir : str.
}
```
