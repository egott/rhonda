class Bot extends React.Component {
  handleClick() {

    const form_input = this.refs.textBox.value
    $.ajax({
      type: "POST",
      url: "https://hello-rhonda.herokuapp.com/bots",
      data: {
        user_input: form_input
      }
    })
    .done(function(response){
      bot_response = response.result.fulfillment.speech
      console.log(bot_response)
      console.log(response)

    })
  }
  render() {
    let bot_response = ""
    return(
      <div>
        <div className="container">
          <input id="speech" type="text" ref= "textBox"/>
          <br/><br/>
          <button id="rec" className="btn" onClick={this.handleClick.bind(this)}>Ask</button>
          <div id="spokenResponse" className="spoken-response">
          <div className="spoken-response__text"></div>
          </div>
          <p> {bot_response} </p>
        </div>
      </div>
      )
  }
}
