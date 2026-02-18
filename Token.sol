// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token {

    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint public totalSupply;

    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint)) public allowance;

    event Transfer(address indexed from,address indexed to,uint value);
    event Approval(address indexed owner,address indexed spender,uint value);

    constructor(string memory _name,string memory _symbol){
        name=_name;
        symbol=_symbol;

        uint supply = 1_000_000 ether;
        totalSupply=supply;
        balanceOf[msg.sender]=supply;
        emit Transfer(address(0),msg.sender,supply);
    }

    function transfer(address to,uint value) external returns(bool){
        require(balanceOf[msg.sender]>=value,"balance low");

        balanceOf[msg.sender]-=value;
        balanceOf[to]+=value;

        emit Transfer(msg.sender,to,value);
        return true;
    }

    function approve(address spender,uint value) external returns(bool){
        allowance[msg.sender][spender]=value;
        emit Approval(msg.sender,spender,value);
        return true;
    }

    function transferFrom(address from,address to,uint value) external returns(bool){
        require(balanceOf[from]>=value,"balance low");
        require(allowance[from][msg.sender]>=value,"not approved");

        allowance[from][msg.sender]-=value;
        balanceOf[from]-=value;
        balanceOf[to]+=value;

        emit Transfer(from,to,value);
        return true;
    }
}
