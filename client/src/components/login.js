import React from 'react' ;
import { Link , Redirect} from 'react-router-dom';
import '../styles/login.css'
import {Navbar} from './navbarhomepg'


export class Login extends React.Component {
    
    constructor() {
        
        super();
        this.state={
            
            redirectToHome:false,
            redirectToSignup:false
        }

        this.handleLogin=this.handleLogin.bind(this);
        this.handleSignup=this.handleSignup.bind(this);
    }
    handleSignup(){
        this.setState({
            redirectToSignup: true
        })
    }
    handleLogin(e){

        e.preventDefault();
        console.log("Adding")
        
        const obj={
            username: e.target.username.value,
            password: e.target.password.value
        }

        fetch("http://localhost:3001/users/login",{
        
        method:"POST",
        headers: {
            "Content-Type" : "application/json" ,
        },
        body: JSON.stringify(obj)
        })
        .then(res => {
            console.log(res);
            if (res.ok) return res.json()
            else throw new Error()
        })
        .then(res => {
             this.props.dealSubmit();
            this.setState({redirectToHome:true});
        })
        .catch(error => {
            
            alert('Wrong UserName Password')
            console.error(`Error adding user: ${error}`)
        })
    }
    render() {
        
        if(this.state.redirectToHome)
        {
            return <Redirect to="/main"/>
        }
        if(this.state.redirectToSignup)
        {
            return <Redirect to="/signup"/>
        }
        return ( 
         <div className='Login-component'>
             <Navbar />
            <div className="login-page">
                <div className="form">
          
                    <form onSubmit={this.handleLogin}>
                        <input type="text" placeholder="&#xf007;  Username" name="username" required/>
                        <input type="password" placeholder="&#xf023;  Password" name="password" required/>
                        <button type="submit" id="submit">LOGIN</button>
                    </form>
          
                    <form className="login-form" onSubmit={this.handleSignup} >
                        <button type="submit">SIGN UP</button>
                     </form>
                </div>
            </div>
        </div>
        )

        
    }
}