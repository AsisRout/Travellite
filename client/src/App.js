import React from 'react';
import 'bootstrap/dist/css/bootstrap.css';
import {Link,Route,Switch,Redirect,BrowserRouter as Router} from 'react-router-dom';
import {Navbar} from './components/navbar';
import {Main} from './components/main'
import { Login } from './components/login';
import { Signup } from './components/signup';
import { CityHotels } from './components/cityHotels';
import { HotelDetails } from './components/hotelDetails';
import { LoadingIndicator } from './components/loadingIndicator';
import { NotFound} from './components/notFound';
import { Hotels } from './components/hotels';
import { BookNow } from './components/bookNow';
import {ConfirmHotel} from './components/confirmHotel';
import { Thankyou } from './components/Thankyou';
import { MyBooking } from './components/myBookings';
import { Homepage } from './components/homepage';
import { Admin } from './components/Admin/admin' ;
import { Adminhotel } from './components/Admin/adminhotel' ;
require('dotenv').config();

class App extends React.Component {
  constructor() {
    super();
    this.state={
      isAuth:false,
      response:[] ,
      cityResponse:JSON.parse(localStorage.getItem('cityResponse')) || [] ,
      loading:false ,
      orderBy:'popularity',
      city:"",
      checkin:"",
      checkout:"",
      rooms:1 ,
      hotelName:"",
      hotelResp:{},
      overallPrice:"",
      overallRooms:""
    }       
    this.getResponse=this.getResponse.bind(this);
    this.getResponse2=this.getResponse2.bind(this);
    this.orderFun=this.orderFun.bind(this);
    this.getSecondResponse=this.getSecondResponse.bind(this);
    this.dealSubmit=this.dealSubmit.bind(this);
    this.dealLogout=this.dealLogout.bind(this);
    this.handlePriceChange=this.handlePriceChange.bind(this);
    this.handleReviewChange=this.handleReviewChange.bind(this);
    this.setHotelName=this.setHotelName.bind(this);
    this.setHotelResp=this.setHotelResp.bind(this);
    this.confirm=this.confirm.bind(this);
  }
  
  componentDidMount() {
    fetch("http://localhost:3001/users/checkUser",{
        method:"GET",
        headers: {
            "Content-Type" : "application/json"
        }
        })
        .then(res => {
          console.log(res);
            if (res.ok) {
              this.setState({isAuth:true})
            }
            else {
              if(this.state.isAuth===true)
              {
                this.setState({isAuth:false})
              }
            }
            return;
        })
        .catch(error => {
            alert('not auth')
            this.setState({redirectToSignup:true});
            console.error(`Error adding user: ${error}`)
        })
  }

  async getResponse() 
  {
    let today = new Date();
    let tommorrow = new Date();
    tommorrow.setDate(today.getDate()+1);
    let formatted_date = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate()
    let next_date = tommorrow.getFullYear() + "-" + (tommorrow.getMonth() + 1) + "-" + tommorrow.getDate();
    
    this.setState({checkin:formatted_date,checkout:next_date})  
      
  }

  async getSecondResponse(city,ad,dd,rooms)
  {
    console.log('Second res')
    this.setState({loading:true})
    try{
      const response=  await fetch(`http://localhost:3001/cityhotels?city=${encodeURIComponent(city)}`, {
         method: "GET",
         headers: {
          "Content-Type" : "application/json" ,
          },
        })
        if(!response.ok)
            throw Error('error fetching data');

        let json_res=await response.json();
        console.log(JSON.stringify(json_res));
        console.log(json_res[0].total_price);
        var arr=[]
        let i=0,j=0,size= json_res[0].length;
        if(size>5)
          size=5;
        for(;j<size;j++){
            arr[i]=json_res[0][j];
            i++;
          }
  
        console.log(arr);
        this.setState({cityResponse:arr , loading:false})
        localStorage.setItem('cityResponse', JSON.stringify(this.state.cityResponse))
        console.log('city response is ',this.state["cityResponse"]["0"]);
      } 
    catch(err){
        console.log(err);
    }
  }

  orderFun(x)
  {
    let demoarr=this.state.cityResponse;
    if (x==="price_ascending")
    {
      demoarr.sort((a,b)=>{return a.Price-b.Price});     
    }
    if (x==="price_descending")
    {
      demoarr.sort((a,b)=>{return a.Price-b.Price});  
      demoarr.reverse();   
    }
    if ( x==="name")
    {
      demoarr.sort((a, b)=>{
        var m = a.name.toLowerCase();
        var n = b.name.toLowerCase();
        if (m < n) {return -1;}
        if (m > n) {return 1;}
        return 0;
      });
    }
    if ( x==="ratings")
    {
      demoarr.sort((a,b)=>{return a.Rating-b.Rating});
    }
    if( x==="popularity")
    {
      demoarr=JSON.parse(localStorage.getItem('cityResponse'));
    }
    this.setState({cityResponse:demoarr});
  }
 
  async getResponse2(city,ad,dd,room)
  {
   
    this.setState({loading:true})
    await this.getResponse();
    if(this.state.response===undefined)
    return;
    await this.getSecondResponse(city,ad,dd,room);
    this.setState({city:city , checkin:ad , checkout:dd , rooms:room})  
  }

    dealSubmit() {
      this.setState({isAuth:true}); 
    }

    dealLogout() {
      fetch("http://localhost:3001/users/logout",{
        method:"GET",
        headers: {
            "Content-Type" : "application/json"
        }
        })
        .then(res => {
            if (res.ok) {
              this.setState({isAuth:false});
            }
            return;
        })
        .catch(error => {
            alert('error')
            //this.setState({redirectToSignup:true});
            //console.error(`Error adding user: ${error}`)
        })
      
    }

    handlePriceChange(price){
      let priceint=parseInt(price);
      let priceArr=JSON.parse(localStorage.getItem('cityResponse'));
      console.log(priceint,priceArr);
      if(price==="All")
      {
        priceArr=JSON.parse(localStorage.getItem('cityResponse'));
      }
      else if(priceint===10000)
      {
        priceArr=priceArr.filter(item=>item.Price>=priceint)
      }
      else
      {
        priceArr=priceArr.filter(item=>(item.Price>=priceint-2000 && item.Price<=priceint))
      }
      console.log(priceArr);
      this.setState({cityResponse:priceArr});
    }

    handleReviewChange(review)
    {
      let priceArr=JSON.parse(localStorage.getItem('cityResponse'));
      if(review==="All")
        priceArr=JSON.parse(localStorage.getItem('cityResponse'));
      else
        priceArr=priceArr.filter(res=>(res.rating_message===review))
      this.setState({cityResponse:priceArr});
    }
    
    setHotelName(hN){
      this.setState({hotelName:hN})
    }

    async setHotelResp(resp){
      await this.setState({hotelResp:resp});
      await this.setState({hotelName: resp.name });
      //console.log(this.state.hotelResp.hotel_name);
    }

    async confirm(price,roomss,checkin,checkout)
    {
      await this.setState({overallPrice:price, overallRooms:roomss, 
      checkin:checkin, checkout:checkout});
      console.log(this.state.overallPrice)
    }


  render() {
    console.log("rendered",this.state.isAuth);
    return (	
      <Router>
        <div>
        <Switch>
           
            <Route exact path="/" render={ ()=><Homepage/>}></Route>;
            
            <Route exact path="/main" render={ ()=> this.state.isAuth ? <Main setHotelResp={this.setHotelResp} getResponse={this.getResponse} response={this.state.response} getResponse2={this.getResponse2} cityResponse={this.state.cityResponse}  getSecondResponse={this.getSecondResponse} dealLogout={this.dealLogout} /> : <Redirect to="/login"/>} ></Route>

            <Route exact path="/about" render = { ()=> ( <Hotels dealLogout={this.dealLogout} getResponse2={this.getResponse2} cityResponse={this.cityResponse} /> )}></Route>
            
            <Route exact path="/cityhotels" render = { ()=> this.state.isAuth? (<CityHotels city={this.state.city} setHotelResp={this.setHotelResp} setHotel={this.setHotelName} cityResponse={this.state.cityResponse} orderFun={this.orderFun} loading={this.state.loading} handlePriceChange={this.handlePriceChange} handleReviewChange={this.handleReviewChange} dealLogout={this.dealLogout} />):<Redirect to="/main"/>}></Route>
            
            <Route exact path="/hoteldetails" render = { ()=> this.state.isAuth? ( <HotelDetails city={this.city} confirm={this.confirm} hotelResp={this.state.hotelResp} dealLogout={this.dealLogout} />):<Redirect to="/main"/>}></Route>
            
            <Route exact path="/signup" render={()=> this.state.isAuth?<Redirect to="/main"/>:<Signup/>}></Route>
            
            <Route exact path="/login" render = { ()=> this.state.isAuth ? <Redirect to="/main"/>: <Login dealSubmit={this.dealSubmit} /> }></Route>
            
            <Route exact path="/booknow" render = { ()=> this.state.isAuth? ( <BookNow confirm={this.confirm} hotelResp={this.state.hotelResp} checkin={this.state.checkin} checkout={this.state.checkout} rooms={this.state.rooms} hotelName={this.state.hotelName} dealLogout={this.dealLogout} />):<Redirect to="/main"/>}></Route>
            
            <Route exact path="/confirmhotel" render = { ()=> this.state.isAuth? ( <ConfirmHotel  hotelResp={this.state.hotelResp} prc= {this.state.overallPrice} rooms = {this.state.overallRooms} dealLogout={this.dealLogout} checkin={this.state.checkin} checkout={this.state.checkout}/> ):<Redirect to="/main"/>} />
            
            <Route exact path="/thankyou" render={()=>(<Thankyou dealLogout={this.dealLogout}/>)}></Route>

            <Route exact path="/mybookings" render={()=>(<MyBooking dealLogout={this.dealLogout} />)}></Route>
            
            <Route exact path="/admin" render={()=>(<Admin />)}></Route>

            <Route exact path="/admin/hotel" render={()=>(<Adminhotel />)}></Route>

            <Route render={()=>(<NotFound/>)}></Route>
          
      
        </Switch> 
      </div>

      </Router>
    )
  }

  
}

export default App;

//"9f8ad6c750mshf0b1f680b88141ep1deb54jsndb7cd93136e0"
