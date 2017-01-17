class Bot extends React.Component {
  handleClick() {
    const form_input = this.refs.textBox.value
    $.ajax({
      type: "POST",
      url: "/bot",
      data: {
        user_input: form_input
      }
    })
    .done(function(response){
      debugger
      bot_response = response.speech
      if ('url' in response == true) {
        link = response.url
        giph = ""
      } else if ('giph' in response == true) {
        giph = response.giph
        link = ""
      }
      else {
        link = "",
        giph = ""
      }
      this.props.onNewRespond(bot_response, link, giph)
      this.props.onNewQuestion(form_input)
    }.bind(this))
  }
  render() {
    return(
      <div>
        <div className="container">
          {/* <form onSubmit={this.handleSubmit.bind(this)}> */}
            <input id="speech" type="text" ref= "textBox" placeholder="Start typing..."/>
            {/* <input type="submit" /> */}
          {/* </form> */}
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
