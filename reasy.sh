#!/bin/sh

# Get react app name from argument
name=$1 
st=1

# Function to create react app 
create_react_app(){
    # Check if argument is passed
    
    if [ -z "$name" ] 
    then
        echo "No filename passed as an argument"
        st=0
        return  
    fi

    # Check if directory with same app name already exists
    if [ -d "$name" ]
    then 
        echo "Directory with name: $name already exists..."
        st=0
        return
    fi
    
    # Starting to create react app/
    echo "Creating a react app : $name"

    npx create-react-app $name

    # Check if the command was a success  
    if [ $? -eq 0 ] 
    then
        echo "Created react app"
        return 
    else
        echo "Failed to create react app"
    fi
    st=0
}

# Function to remove boilerplate src code
remove_boilerplate_src(){
    
    # Check if previous function executed successfully

    if [ $st -eq 0 ] 
    then 
        return 
    fi

    # Starting to remove boilerplate src

    echo "Removing boilerplate src code"
    rm -R $name/src

    # Check if the command was a success
    if [ $? -eq 0 ]
    then
        echo "Successfully removed src code..."
        return
    else
        echo "Failed to remove src..."
    fi
    st=0
}

# Function to create custom src
create_custom_src(){
    
    # Check if previous function executed successfully
    
    if [ $st -eq 0 ]
    then 
        return 
    fi
    
    # Begin to generate custom src code

    echo "Generating custom src code...."
    mkdir $name/src
    
    # Check if the command was a success

    if [ $st -neq 0 ]
    then
        st=0
        return
    fi

    echo "Folder src created..."
    
    # Hard coded the src/index.js file 
    # Trying to find something more interesting

    echo "Creating src/index.js"

    echo "import React from 'react' 
    import ReactDOM from 'react-dom'
    import App from './App'

    ReactDOM.render(<App/>,document.getElementById('root'));" > $name/src/index.js

    echo "src/index.js created..."

    # Hard coded the src/App.js file
    # Trying to find something more interesting for this too. 

    echo "Creating src/App.js"
    echo "import React from 'react'

    export default function App(){
    return(
        <div>Hello World!!</div> 
        )
    }" > $name/src/App.js

    echo "Created src/App.js"
}

# Function to create the typical React app directories
init_directories(){

    # Check if the previous function executed successfully

    if [ $st -eq 0 ]
    then
        return
    fi

    # Begin to create the directories
    echo "Creating basic directories"

    mkdir $name/src/Components
    
    # Check if the command was a success
    if [ $? -eq 0 ]
    then 
        echo "Created directory: src/Components"    
    else
        echo "Failed to create: src/Components"
        st=0
    fi
    
    mkdir $name/src/Assets

    # Check if the command was a success
    if [ $? -eq 0 ] 
    then
        echo "Created directory: src/Assets"
    else
        echo "Failed to create : src/Assets"
        st=0
    fi
}

# Todo : Adding custom scripts to package.json
add_custom_scripts(){

    # Check if the previous function executed successfully
    if [ $st -eq 0 ]
    then
        return 
    fi

    custom_scripts="\"gitpush\": \"git add . && git commit -m 'UI Build' && git push\""

    echo "Adding custom script to package.json"

    echo "Custom scripts added successfully..."
}


# Calling the functions in order
create_react_app
remove_boilerplate_src
create_custom_src
init_directories