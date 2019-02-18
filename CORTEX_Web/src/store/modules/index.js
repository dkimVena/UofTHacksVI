import { combineReducers } from 'redux';
import { penderReducer } from 'redux-pender';
import user from './user';

export default combineReducers({
  user,
  pender: penderReducer
});
