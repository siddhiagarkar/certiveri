//STEP 1

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CertificateVerification is Ownable {

    constructor() Ownable(msg.sender) {}

    // Struct to store certificate details
    struct Certificate {
        string studentName;
        string issuerName;
        string courseName;
        uint256 issueDate;
        bool isVerified;
    }

    // Mapping from certificate hash (unique ID) to Certificate
    mapping(bytes32 => Certificate) public certificates;

    // Event to log when a certificate is issued
    event CertificateIssued(bytes32 indexed certificateHash, string studentName, string issuerName, string courseName);

    // Event to log when a certificate is verified
    event CertificateVerified(bytes32 indexed certificateHash, bool isVerified);

    /**
     * @dev Issue a new certificate
     * @param _studentName Name of the student
     * @param _issuerName Name of the issuer
     * @param _courseName Name of the course
     * @param _certificateHash Unique hash of the certificate (generated off-chain)
     */
    function issueCertificate(
        string memory _studentName,
        string memory _issuerName,
        string memory _courseName,
        bytes32 _certificateHash
    ) public onlyOwner {
        require(certificates[_certificateHash].issueDate == 0, "Certificate already exists!");
        
        certificates[_certificateHash] = Certificate({
            studentName: _studentName,
            issuerName: _issuerName,
            courseName: _courseName,
            issueDate: block.timestamp,
            isVerified: true
        });

        emit CertificateIssued(_certificateHash, _studentName, _issuerName, _courseName);
    }

    /**
     * @dev Verify a certificate by its hash
     * @param _certificateHash Unique hash of the certificate
     */
    function verifyCertificate(bytes32 _certificateHash) public view returns (bool, string memory, string memory, string memory, uint256) {
        Certificate memory cert = certificates[_certificateHash];
        require(cert.issueDate != 0, "Certificate does not exist!");
        
        return (cert.isVerified, cert.studentName, cert.issuerName, cert.courseName, cert.issueDate);
    }
}