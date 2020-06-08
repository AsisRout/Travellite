import React from 'react';
import {Navbar} from './navbar';
import { Link } from 'react-router-dom';

export class Adminhotel extends React.Component {
    constructor(){
        super();

        this.state = {
            hotels : [],
        }

    }
    componentDidMount() {

        fetch(`http://localhost:3001/admin/hotels`, {
            method:"GET",
            headers: {
                "Content-Type" : "application/json"
            },
          })
          .then((response)=> {
            return response.json()
          })
          .then(res => {
            console.log(JSON.stringify(res));
            var arr=[];
            let size= res.length;
            for(let i=0;i<size;i++)
            {
              arr[i]=res[i];
            }
            this.setState({hotels:arr})  
          })
        
    }

        render() {
            return (
                <div>
                    <Navbar />
                    <br />
                    <br />
                <div className="py-4">
                <table class="table border shadow">
                 <thead class="thead-dark">
                  <tr>
                  <th scope="col">#</th>
                 <th scope="col">Hotel Name</th>
                 <th scope="col">Daily Cost</th>
                 <th scope="col">Rooms Available</th>
                 <th scope="col">Address</th>
                 <th scope="col">Rating</th>
                 <th>Action</th>
                  </tr>
                 </thead>
                 <tbody>
            {this.state.hotels.map((hotel, index) => (
              <tr>
                <th scope="row">{index + 1}</th>
                <td>{hotel.name}</td>
                <td>{hotel.dailyCost}</td>
                <td>{hotel.roomAvi}</td>
                <td>{hotel.address}</td>
                <td>{hotel.noOfStar}</td>
                <td>
                  <Link class="btn btn-primary mr-2" to={`/users/${hotel.id}`}>
                    View
                  </Link>
                  <Link
                    class="btn btn-outline-primary mr-2"
                    to={`/users/edit/${hotel.id}`}
                  >
                    Edit
                  </Link>
                  <Link
                    class="btn btn-danger"
                  >
                    Delete
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
                </table>
                </div>
                </div>

            );
        }


    }
