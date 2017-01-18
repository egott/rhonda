class NavBar extends React.Component {
  render() {
    return (
      <div>
      <nav id="mainNav" className="navbar navbar-default navbar-fixed-top navbar-custom">
        <div className="container">
            <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul className="nav navbar-nav navbar-right">
                    <li>
                        <a href="/signout">logout</a>
                    </li>
                    <li>
                        <a href="/">home</a>
                    </li>
                    <li>
                        <a href="/">documentation</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
      </div>
    )
  }
}
