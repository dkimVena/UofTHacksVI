import { bindActionCreators } from 'redux';

import * as userActions from './modules/user';

import store from './index';

const { dispatch } = store;

export const UserActions = bindActionCreators(userActions, dispatch);
