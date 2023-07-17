//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract MyERC20 {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 private totalTokenSupply;

    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint256)) private allowed;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol =_symbol;
        decimals = 18;
        totalTokenSupply = 1000000 * (10 ** uint256(decimals));
        balances[msg.sender] = totalTokenSupply;
    }

    function totalSupply() public view returns (uint256) {
        return totalTokenSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(_to != address(0), "Invalid Address");
        require(_amount <= balances[msg.sender], "Insufficiant amount");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function approve(address _spender, uint256 _amount) public returns (bool) {
        require(_spender != address(0), "Invalid Address");

        allowed[msg.sender][_spender] = _amount;

        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool) {
        require(_from != address(0), "Invalid Address");
        require(_to != address(0), "Invalid Address");
        require(_amount <= balances[_from], "Insufficient balance");
        require(_amount <= allowed[_from][msg.sender], "Insufficient allowance");

        balances[_from] -= _amount;
        balances[_to] += _amount;
        allowed[_from][msg.sender] -= _amount;

        emit Transfer(_from, _to, _amount);
        return true;
    }

    function increaseAllowance(address _spender, uint256 _addedamount) public returns (bool) {
        require(_spender != address(0), "Invalid spender");

        allowed[msg.sender][_spender] += _addedamount;

        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _subtractedamount) public returns (bool) {
        require(_spender != address(0), "Invalid spender");

        uint256 oldValue = allowed[msg.sender][_spender];

        if (_subtractedamount >= oldValue) {
            allowed[msg.sender][_spender] = 0;
        } else {
            allowed[msg.sender][_spender] -= _subtractedamount;
        }

        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }
}
