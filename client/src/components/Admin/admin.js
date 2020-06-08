import React from 'react';
import {Navbar} from './navbar';
import { Link } from 'react-router-dom';

export class Admin extends React.Component {
    constructor(){
        super();

        this.state = {
            users : [],
            hotels : [],
            tourbook : [],
        }

    }
    componentDidMount() {

        fetch(`http://localhost:3001/admin/users`, {
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
            this.setState({users:arr})  
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
                 <th scope="col">Name</th>
                 <th scope="col">User Name</th>
                 <th scope="col">Email</th>
                 <th scope="col">Password</th>
                 <th>Action</th>
                  </tr>
                 </thead>
                 <tbody>
            {this.state.users.map((user, index) => (
              <tr>
                <th scope="row">{index + 1}</th>
                <td>{user.fullname}</td>
                <td>{user.username}</td>
                <td>{user.email}</td>
                <td>{user.password}</td>
                <td>
                  <Link class="btn btn-primary mr-2" to={`/users/${user.id}`}>
                    View
                  </Link>
                  <Link
                    class="btn btn-outline-primary mr-2"
                    to={`/users/edit/${user.id}`}
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
