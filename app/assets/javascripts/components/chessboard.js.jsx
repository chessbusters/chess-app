var Chessboard = React.createClass({

  renderMeow: function(){
    var array = [1,2,3,4,5,6,7,8];
    return (
      <table>
          {array.map(function(row, rowindex){
            return <tr key={rowindex}>
              {array.map(function(col, colindex){
             return <td className='{col}x#{row}' key={colindex}/>
        })
      }
          </tr>
        })
    }
    </table>
    )
  },


  render: function() {
    return(
      <div>
        <h1> your game</h1>
<br />
<h2> this.props.name </h2>
        {this.renderMeow()}
    </div>
  );}
});

