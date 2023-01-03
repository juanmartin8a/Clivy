import { User } from "../../entities/User";
import { RegisterInput, SignInInput, UserUpdateInput } from "./userInput";
import argon2 from 'argon2';


export const validateRegister = async (options: RegisterInput) => {
  const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  const spacesRegex = /\s/g;
  //(?=.*?[#?!@$%^&*-]) --> this is for special character
  // (?=.*?[A-Z]) --> this is for upper case letter
  const passwordRegex = /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/;

  const validateUsernameExistance = await validateUsernameExists(options.username);

  if (validateUsernameExistance.length > 0) {
    return validateUsernameExistance
  }

  const checkIfEmailExists = await User.findOne({where: {email: options.email}});
  if (checkIfEmailExists) {
    return [
      {
        field: 'email',
        message: 'email is already taken'
      }
    ];
  }

  const errorsArray = [];

  const usernameHasSpace = spacesRegex.test(options.username);
  const passwordHasSpace = spacesRegex.test(options.password);

  if (!emailRegex.test(options.email)) {
    errorsArray.push({
      field: 'email',
      message: 'invalid email'
    });
  }

  const validateUsernameInput = await validateUsername(options.username, usernameHasSpace);

  if (validateUsernameInput.length > 0) {
    errorsArray.push(...validateUsernameInput);
  }

  const validateNameInput = await validateName(options.name);

  if (validateNameInput.length > 0) {
    errorsArray.push(...validateNameInput);
  }

  if (options.password.length < 8 || !passwordRegex.test(options.password)
    || passwordHasSpace) {
    if (options.password.length < 8) {
      errorsArray.push({
        field: 'password',
        message: 'password must have at least 8 characters'
      });
    } else if (passwordHasSpace) {
      errorsArray.push({
        field: 'password',
        message: 'password must not have any spaces'
      });
    } else if (!passwordRegex.test(options.password)) {
      errorsArray.push({
        field: 'password',
        message: 'password must have at least one lower case and one number'
      });
    }
  }

  return errorsArray;
}

export const validateSignIn = async (options: SignInInput) => {
    
    const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    const user = await User.findOne({where: emailRegex.test(options.usernameOrEmail) 
      ? {email: options.usernameOrEmail} 
      : {username: options.usernameOrEmail} 
    });
    
    if (!user) {
      return {
        errors: [
          {
            field: 'usernameOrEmail',
            message: 'user does not exist'
          }
        ],
        user: null
      }
    }

    const validatePassword = await argon2.verify((user as User).password, options.password);
    if (!validatePassword) {
      return {
        errors: [
          {
            field: 'password',
            message: 'incorrect password'
          }
        ],
        user: null
      }
    }
  
    return {errors: [], user: user};
}

export const validateUserFields = async (input: UserUpdateInput, userId: number) => {

  const errorsArray = [];

  if (input.username) {
    
    const validate = await validateUsernameExists(input.username, userId);
    
    if (validate.length > 0) {
      return validate
    }
    
    const spacesRegex = /\s/g;
    const usernameHasSpace = spacesRegex.test(input.username);

    const validateUsernameInput = await validateUsername(input.username, usernameHasSpace);

    if (validateUsernameInput.length > 0) {
      errorsArray.push(...validateUsernameInput);
    }
  }

  if (input.name) {
    const validateNameInput = await validateName(input.name);

    if (validateNameInput.length > 0) {
      errorsArray.push(...validateNameInput);
    }
  }

  if (input.bio) {
    const validateBioInput = await validateBio(input.bio);

    if (validateBioInput.length > 0) {
      errorsArray.push(...validateBioInput);
    }
  }

  return errorsArray;
}

export const validateUsernameExists = async (username: string, usernameId?: number) => {

  const errorsArray = []

  const checkIfUsernameExists = await User.findOne({where: {username: username}});

  if (usernameId) {
    if (checkIfUsernameExists) {
      if (checkIfUsernameExists.id != usernameId) {
        errorsArray.push({
          field: 'username',
          message: 'username is already taken'
        });
      }
    }
  } else {
    if (checkIfUsernameExists) {
      errorsArray.push({
        field: 'username',
        message: 'username is already taken'
      });
    }
  }


  return errorsArray;
}

export const validateUsername = async (username: string, usernameHasSpace: boolean) => {

  const errorsArray = []

  if (username.length < 2 || username.length > 30
    || usernameHasSpace || username !== username.toLowerCase()) {
    if (username.length == 0) {
      errorsArray.push({
        field: 'username',
        message: 'username must not be empty'
      });
    } else if (username.length < 2) {
      errorsArray.push({
        field: 'username',
        message: 'username must have at least 2 characters'
      });
    } else if (usernameHasSpace) {
      errorsArray.push({
        field: 'username',
        message: 'username must not have any spaces'
      });
    } else if (username.length > 30) {
      errorsArray.push({
        field: 'username',
        message: 'username must have no more than 30 characters'
      });
    } else if (username !== username.toLowerCase()) {
      errorsArray.push({
        field: 'username',
        message: 'username must be in lower case only'
      });
    }
  }

  return errorsArray;
}

export const validateName = async (name: string) => {

  const errorsArray = []

  if (name.length < 2 || name.length > 30) {
    if (name.length == 0) {
      errorsArray.push({
        field: 'name',
        message: 'name must not be empty'
      });
    } else if (name.length < 2) {
      errorsArray.push({
        field: 'name',
        message: 'name must have at least 2 characters'
      });
    } else if (name.length > 30) {
      errorsArray.push({
        field: 'name',
        message: 'name must have no more than 30 characters'
      });
    }
  }

  return errorsArray;
}

export const validateBio = async (bio: string) => {

  const errorsArray = []

  if (bio.length > 150) {
    errorsArray.push({
      field: 'bio',
      message: 'bio must have no more than 150 characters'
    });
  }

  return errorsArray;
}