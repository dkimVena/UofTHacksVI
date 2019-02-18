import React, { Component } from 'react';

import { connect } from 'react-redux';
import Progress from 'components/Progress';
import firebase from 'lib/firebase';
import Header from 'components/Header';
import Footer from 'components/Footer';
import { Container } from 'semantic-ui-react';
import { UserActions } from 'store/actionCreators';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

class App extends Component {
  handleSignOut = () => {
    firebase
      .auth()
      .signOut()
      .then(() => console.log('signed out'));
  };

  sendMoney = (name, email, amount) => {
    try {
      UserActions.sendMoney(name, email, amount);
      this.setToast();
    } catch (err) {
      console.log(err);
    }
  };

  setToast = () => {
    toast('Thanks for your fund raising !');
  };

  render() {
    const { currentUser } = this.props;

    return (
      <div className="app">
        <Header
          handleSignOut={this.handleSignOut}
          sendMoney={this.sendMoney}
          currentUser={currentUser}
        />
        <Container text style={{ marginTop: '4em' }}>
          <Progress currentUser={currentUser} />
        </Container>
        <Footer />
        <ToastContainer />
      </div>
    );
  }
}

export default connect(({ user }) => {
  const { currentUser } = user;

  return {
    currentUser
  };
})(App);
