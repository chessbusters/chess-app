class Game extends React.Component {
    render () {
      return (
        <div>
        <h1> Hey everyone </h1>
        {this.props.game.map(function(x){
          return(
            <h2 className="text-center"><a href={"/games/" + x.id}> {x.name} </a></h2>
            )
        })}
      </div>
      )
    }
}