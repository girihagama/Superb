/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function regexValidation() {
    var exp = arguments[0];

    var characterReg = /[\s\\\+\*\?\^\$\[\]\{\}\(\)\|\/\,\:\'\"\;\!\#\%\&\<\>\-\=]/;

    if (!characterReg.test(exp)) {
        return true;
    } else {
        return false;
    }
}
