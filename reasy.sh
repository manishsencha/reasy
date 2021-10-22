#!/bin/sh

name=$1
st=1
create_react_app(){

    if [ -z "$name" ] 
    then
        echo "No filename passed as an argument"
        st=0
        return  
    fi

    if [ -d "$name" ]
    then 
        echo "Directory with name: $name already exists..."
        st=0
        return
    fi
    echo "Creating a react app : $name"

    npx create-react-app $name
    
    if [ $? -eq 0 ] 
    then
        echo "Created react app"
        return 
    fi
    st=0
}

remove_boilerplate_src(){
    if [ $st -eq 0 ] 
    then 
        return 
    fi

    echo "Removing boilerplate src code"
    rm -R $name/src
    if [ $? -eq 0 ]
    then
        echo "Successfully removed src code..."
        return
    else
        echo "Failed to remove src..."
    fi
    st=0
}

create_custom_src(){
    if [ $st -eq 0 ]
    then 
        return 
    fi
    echo "Generating custom src code...."
    mkdir $name/src
    if [ $st -eq 0 ]
    then
        continue
    else
        st=0
        return
    fi
    echo "Folder src created..."

    echo "Creating src/index.js"

    echo "import React from 'react' 
    import ReactDOM from 'react-dom'
    import App from './App'

    ReactDOM.render(<App/>,document.getElementById('root'));" > $name/src/index.js

    echo "src/index.js created..."

    echo "Creating src/App.js"
    echo "import React from 'react'

    export default function App(){
    return(
        <div>Hello World!!</div> 
        )
    }" > $name/src/App.js

    echo "Created src/App.js"
}

init_directories(){
    if [ $st -eq 0 ]
    then
        return
    fi

    echo "Creating basic directories"

    mkdir $name/src/Components
    if [ $? -eq 0 ]
    then 
        echo "Created directory: src/Components"    
    else
        echo "Failed to create: src/Components"
        st=0
    fi
    
    mkdir $name/src/Assets

    if [ $? -eq 0 ] 
    then
        echo "Created directory: src/Assets"
    else
        echo "Failed to create : src/Assets"
        st=0
    fi
}

add_custom_scripts(){
    if [ $st -eq 1 ]
    then
        return 
    fi

    custom_scripts="\"gitpush\": \"git add . && git commit -m 'UI Build' && git push\""

    echo "Adding custom script to package.json"

    echo "Custom scripts added successfully..."
}

create_react_app
remove_boilerplate_src
create_custom_src
init_directories
