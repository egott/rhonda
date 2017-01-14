class Bot extends React.Component {
  handleClick() {
    const form_input = this.refs.textBox.value
    $.ajax({
      type: "POST",
      url: "/bots",
      data: {
        user_input: form_input
      }
    })
    .done(function(response){
      bot_response = response.speech
      this.props.onNewRespond(bot_response)
      this.props.onNewQuestion(form_input)
    }.bind(this))
  }
  render() {
    return(
      <div>
        <div className="container">
          <input id="speech" type="text" ref= "textBox"/>
          <br/><br/>
          <button id="rec" className="btn" onClick={this.handleClick.bind(this)}>Ask</button>
          <div id="spokenResponse" className="spoken-response">
          <div className="spoken-response__text"></div>
          </div>
        </div>
      </div>
      )
  }
}
