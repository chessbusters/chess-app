var GameForm = React.createClass({

  getInitialState: function(){
    return {name: ""};
  },

  resetState: function(){
    this.setState({name: ""});
  },

  newGameSubmit: function(e){
    e.preventDefault();

   this.props.parentGameSubmit({game: {name: this.state.name, white_castling: this.state.white_castling, black_castling: this.state.black_castling}},
    this.resetState);
   this.setState({name: ''});
  },

  handleNameChange: function(e){
    this.setState({name: e.target.value});
  },


  renderGameNameField: function(){


    return(

      <div className='row'>

        <div className='col-sm-4'>

          <div className= 'form-group'>

            <input
              name="game[name]"
              type="string"
              placeholder="Game name"
              value={this.state.name}
              onChange={this.handleNameChange}
              className="string form-control"
            />

          </div>

        </div>

      </div>
    );
  },



  render: function() {

    return(
      <div>
        <h4 style={{marginTop: "50px"}}> Create New Game </h4>

        <form style={{marginTop: "30px"}} onSubmit={this.newGameSubmit}>

          <div className='form-inputs'/>


            {this.renderGameNameField()}
            


            <div className='row'>
              <div className='col-sm-4'>
                <input type="submit" value="Save" className='btn btn-primary' />
              </div>
            </div>

        </form>

      </div>

    );
  }
});