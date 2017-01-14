class IndexIntroHeader extends React.Component {
  render() {
    return (
      <div className="intro-header">
        <div className="container">
          <div className="row">
            <div className="col-lg-12">
              <div className="intro-message">
                <h1>Hello, Rhonda</h1>
                <h3>your own virtual personal assistant</h3>
                <hr className="intro-divider"/>
                <ul className="list-inline intro-social-buttons">
                  <li>
                    <a href="/auth/google_oauth2" className="btn btn-default btn-lg"><i className="fa fa-github fa-fw"></i> <span className="network-name">get started!</span></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
