import React from 'react';
import '../../styles/booknow.css';
import {Navbar} from '.././navbar';
import {Redirect} from 'react-router-dom';
import StripeCheckout from 'react-stripe-checkout';
import {StripeProvider, injectStripe} from 'react-stripe-elements';



const randomInt = require('random-int');


export class Booking extends React.Component {
  constructor(){
    super();
    this.state ={
      traveldate:"",
      totalmembers:"",
      submitted:false
    }
    this.handleChange = this.handleChange.bind(this);
    this.handleToken=this.handleToken.bind(this);
  }
   handleChange(e){
        this.setState({ [e.target.name]: e.target.value})
  }

  async handleToken(e) {
    e.preventDefault();
    let obj={
        id: randomInt(100000),
        username: this.props.user,
        locationid: this.props.packageResp.touristid,
        traveldate: this.state.traveldate,
        noOfticket: this.state.totalmembers,

    }

    const response=await fetch("http://localhost:3001/bookings/tour/add",{
        method:"POST",
        headers: {
            "Content-Type" : "application/json" ,
        },
        body: JSON.stringify(obj)
        })
        console.log(response)
        if(response.ok) {
            this.setState({submitted:true});
        }
        else
        {
            alert("Error");
        }
  }


    render() {
      if(this.state.submitted===true)
      return (<Redirect to="/thankyou"/>)
      console.log('confirmation rendered');
      let today = new Date();
      let tommorrow = new Date();
      tommorrow.setDate(today.getDate()+1);
      let formatted_date = today.getFullYear() + "-" + (("0" + (today.getMonth() + 1)).slice(-2)) + "-" + ("0" + (today.getDate())).slice(-2)
      let next_date = tommorrow.getFullYear() + "-" + (("0" + (tommorrow.getMonth() + 1)).slice(-2)) + "-" + ("0" + (tommorrow.getDate())).slice(-2)
      console.log(formatted_date);
      console.log(next_date);  

        return (
            <div className="booking">
            <Navbar dealLogout={this.props.dealLogout}/>
            <div className="container">
            <form  onSubmit={this.handleToken}>
               <h4>{this.props.packageResp.tourist_place_name}</h4>
               <h6>Near {this.props.city}</h6>
               <p>Ratings : {this.props.packageResp.numStars}</p>
               <div className="row">
               <div className="col-25">
               <label for="traveldate" >Travel Date</label>
              </div>
              <div className="col-75">
              <input type="date" name="traveldate" id="checkin" min={formatted_date} onChange={this.handleChange}  required />
              </div>
            </div>
          
            <div className="row">
              <div className="col-25">
                <label for="totalmembers">Tickets Count</label>
              </div>
              <div className="col-75">
                <input type="number" name="totalmembers" min="1" max="10" onChange={this.handleChange} />
              </div>
            </div>
            <h4 style={{color:"red"}}>Total Amount : {this.props.packageResp.dailyCost * this.state.totalmembers} INR</h4>
            
            <input type="submit" value="Click here"/> Make Payment
           
            
            </form>
          </div>
          </div>
        )
    }
}

/*
<input type="submit" value="Click here"/> to continue...
*/
