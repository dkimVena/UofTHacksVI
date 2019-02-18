import React, { Component } from 'react';

import InteracPhoto from 'assets/images/interac.png';
import { Modal, Input, Button, Icon, Form, Image } from 'semantic-ui-react';

class FundModal extends Component {
  state = { name: '', amount: '', email: '' };
  sendMoneyRequest = () => {
    const { sendMoney, closeModal } = this.props;
    const { name, amount, email } = this.state;

    try {
      sendMoney(name, email, amount);
      closeModal();
      this.clear();
    } catch (err) {
      console.log(err);
    }
  };

  handleChange = e => {
    this.setState({ [e.target.name]: e.target.value });
  };

  clear = () => {
    this.setState({ name: '', amount: '', email: '' });
  };

  render() {
    const { open, closeModal } = this.props;
    return (
      <Modal basic open={open} onClose={closeModal}>
        <Modal.Header>
          <Image size="mini" src={InteracPhoto} />
          Fund raising
        </Modal.Header>
        <Modal.Content>
          <Form onSubmit={this.sendMoneyRequest}>
            <Form.Field>
              <Input
                fluid
                label="Name"
                name="name"
                onChange={this.handleChange}
              />
            </Form.Field>

            <Form.Field>
              <Input
                fluid
                label="Email"
                name="email"
                onChange={this.handleChange}
              />
            </Form.Field>

            <Form.Field>
              <Input
                fluid
                label="Amount"
                name="amount"
                onChange={this.handleChange}
                type="number"
                placeholder="CAD"
              />
            </Form.Field>
          </Form>
        </Modal.Content>
        <Modal.Actions>
          <Button color="green" inverted onClick={this.sendMoneyRequest}>
            <Icon name="checkmark" /> Fund
          </Button>
          <Button color="red" inverted onClick={closeModal}>
            <Icon name="remove" /> Cancel
          </Button>
        </Modal.Actions>
      </Modal>
    );
  }
}

export default FundModal;
