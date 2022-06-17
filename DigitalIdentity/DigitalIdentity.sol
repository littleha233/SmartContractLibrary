// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DgtId{

    // 数字身份列表（动态数组），真正决定该数字身份是否具有效力
    bytes32[] public dgtidList;
    // 地址到数字身份的映射，只是单纯的映射，不具备约束效力
    mapping public (address=>bytes32) dgtidMap;
    // 记录数字身份是否被添加至数字身份列表中，可以用于快速检验某个数字身份是否具有效力
    mapping public (bytes32=>bool) inserted;

    // 根据地址获得数字身份种子，数字身份种子是对地址取哈希后的结果
    function getSeedId(address _addr) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_addr));
    }

    // 将数字身份添加至全局列表中，对应注册功能
    function addIdentity(address _addr) public {
        bytes32 _id = getSeedId(_addr);
        dgtidList.push(_id);
        dgtidMap._addr = _id;
    }

    // 将注册身份从全局列表中删除，对应注销功能
    function delIdentity(address _addr) public {
        bytes32 _id = getSeedId(_addr);
        inserted[_id] = false;
    }

    // 返回整个数字身份列表
    function getDgtidList() public pure returns(bytes32[] memory){
        return dgtidList;
    }

    // 根据地址查询数字身份
    function queryIdByAddr(address _addr) public view returns(bytes32){
        return dgtidMap[_addr];
    }

    // 快速检验某个数字身份是否有效, 要求数字身份在数字身份列表中
    modifier isValid(bytes32 _id){
        require(inserted[_id], "the digital identity is not in the list");
        _;
    }



    
}