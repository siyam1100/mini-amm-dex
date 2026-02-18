// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20{
    function transferFrom(address,address,uint) external returns(bool);
    function transfer(address,uint) external returns(bool);
    function balanceOf(address) external view returns(uint);
}

contract DEX {

    IERC20 public tokenA;
    IERC20 public tokenB;

    uint public reserveA;
    uint public reserveB;

    mapping(address=>uint) public lpShares;
    uint public totalShares;

    constructor(address _a,address _b){
        tokenA = IERC20(_a);
        tokenB = IERC20(_b);
    }

    function addLiquidity(uint amountA,uint amountB) external {

        tokenA.transferFrom(msg.sender,address(this),amountA);
        tokenB.transferFrom(msg.sender,address(this),amountB);

        uint shares;

        if(totalShares==0){
            shares = sqrt(amountA * amountB);
        } else {
            shares = min(
                (amountA * totalShares)/reserveA,
                (amountB * totalShares)/reserveB
            );
        }

        require(shares>0,"shares=0");

        lpShares[msg.sender]+=shares;
        totalShares+=shares;

        reserveA+=amountA;
        reserveB+=amountB;
    }

    function removeLiquidity(uint shares) external {

        require(lpShares[msg.sender]>=shares,"not enough");

        uint amountA = (shares * reserveA)/totalShares;
        uint amountB = (shares * reserveB)/totalShares;

        lpShares[msg.sender]-=shares;
        totalShares-=shares;

        reserveA-=amountA;
        reserveB-=amountB;

        tokenA.transfer(msg.sender,amountA);
        tokenB.transfer(msg.sender,amountB);
    }

    function swapAforB(uint amountA) external {

        tokenA.transferFrom(msg.sender,address(this),amountA);

        uint amountInWithFee = amountA * 997;
        uint numerator = amountInWithFee * reserveB;
        uint denominator = reserveA*1000 + amountInWithFee;
        uint amountOut = numerator / denominator;

        reserveA+=amountA;
        reserveB-=amountOut;

        tokenB.transfer(msg.sender,amountOut);
    }

    function swapBforA(uint amountB) external {

        tokenB.transferFrom(msg.sender,address(this),amountB);

        uint amountInWithFee = amountB * 997;
        uint numerator = amountInWithFee * reserveA;
        uint denominator = reserveB*1000 + amountInWithFee;
        uint amountOut = numerator / denominator;

        reserveB+=amountB;
        reserveA-=amountOut;

        tokenA.transfer(msg.sender,amountOut);
    }

    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    function min(uint x,uint y) internal pure returns(uint){
        return x<=y?x:y;
    }
}
