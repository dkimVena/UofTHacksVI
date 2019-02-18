import React, { Component } from 'react';

import { Link, withRouter } from 'react-router-dom';
import logo from 'assets/images/logo.png';
import FundModal from 'components/FundModal';
import { Menu, Button, Image } from 'semantic-ui-react';
class Header extends Component {
  state = { modal: false };

  closeModal = () => {
    this.setState({ modal: false });
  };

  openModal = () => {
    this.setState({ modal: true });
  };

  goToHome = () => {
    this.props.history.push('/');
  };

  render() {
    const { handleSignOut, sendMoney, currentUser } = this.props;
    const { modal } = this.state;
    return (
      <Menu inverted>
        <Menu.Item header onClick={this.goToHome}>
          <Image size="mini" src={logo} style={{ marginRight: '1.5em' }} />
          CoreTex
        </Menu.Item>

        <Menu.Item position="right">
          Welcome {currentUser.displayName}
        </Menu.Item>
        <Menu.Item>
          <Button inverted>
            <Link to="/about">About</Link>
          </Button>
        </Menu.Item>
        <Menu.Item>
          <Button as="a" inverted onClick={this.openModal}>
            Fund
          </Button>
        </Menu.Item>
        <Menu.Item>
          <Button as="a" inverted onClick={handleSignOut}>
            Log Out
          </Button>
        </Menu.Item>
        <FundModal
          open={modal}
          closeModal={this.closeModal}
          sendMoney={sendMoney}
        />
      </Menu>
    );
  }
}

export default withRouter(Header);
