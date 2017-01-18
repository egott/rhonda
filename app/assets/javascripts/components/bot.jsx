class Bot extends React.Component {
  handleSubmit(e) {
    e.preventDefault()
    const form_input = this.refs.textBox.value

    this.refs.textBox.value = ''
    $.ajax({
      type: "POST",
      url: "/bot",
      data: {
        user_input: form_input
      }
    })
    .done(function(response){
      bot_response = response.speech
      link = response.url
      giph = response.giph
      this.props.onNewRespond(bot_response, link, giph)
      this.props.onNewQuestion(form_input)
    }.bind(this))
  }
  render() {
    return(
      <div>
        <div className="container">
          <form onSubmit={this.handleSubmit.bind(this)}>
            <input id="speech" type="text" ref= "textBox" placeholder="Start typing..."/>
          </form>
          <br/><br/>

          <div id="spokenResponse" className="spoken-response">
          <div className="spoken-response__text"></div>
          </div>
        </div>
      </div>
      )
  }
}
