;; This contract allows the creation and management of non-fungible tokens (NFTs) representing badges.
;; Only the contract owner has the authority to issue badges, either individually or in batches.
;; Each badge is associated with metadata that describes its properties. Badges are minted sequentially, 
;; with the most recent badge ID tracked to ensure unique identifiers. 
;; The contract includes validation for metadata and batch sizes, ensuring only valid data is processed.
;; Public functions include issuing a badge, issuing badges in a batch, retrieving badge metadata, 
;; and querying ownership information.

;; Constants
(define-constant contract-owner tx-sender)
(define-constant max-batch-size u50)

;; Error Codes
(define-constant err-owner-only (err u100))
(define-constant err-badge-exists (err u101))
(define-constant err-badge-not-found (err u102))
(define-constant err-batch-size-too-large (err u103))
(define-constant err-invalid-metadata (err u104))

;; Data Variables
(define-non-fungible-token badge-id uint)
(define-data-var last-badge-id uint u0)

;; Maps
(define-map badge-metadata uint (string-ascii 256))

;; Private Functions
(define-private (is-valid-metadata (metadata (string-ascii 256)))
    (let ((metadata-length (len metadata)))
        (and (>= metadata-length u1)
             (<= metadata-length u256))))

(define-private (mint-single-badge (metadata (string-ascii 256)))
    (let ((new-badge-id (+ (var-get last-badge-id) u1)))
        (asserts! (is-valid-metadata metadata) err-invalid-metadata)
        (try! (nft-mint? badge-id new-badge-id tx-sender))
        (map-set badge-metadata new-badge-id metadata)
        (var-set last-badge-id new-badge-id)
        (ok new-badge-id)))

(define-private (mint-single-badge-in-batch (metadata (string-ascii 256)) (previous-results (list 50 uint)))
    (match (mint-single-badge metadata)
        success (unwrap-panic (as-max-len? (append previous-results success) u50))
        error previous-results))

;; Public Functions

(define-public (batch-issue-badges (metadatas (list 50 (string-ascii 256))))
    (let ((batch-size (len metadatas)))
        (begin
            (asserts! (is-eq tx-sender contract-owner) err-owner-only)
            (asserts! (<= batch-size max-batch-size) err-batch-size-too-large)
            (asserts! (> batch-size u0) err-batch-size-too-large)

            ;; Use fold to process the metadata and mint badges
            (ok (fold mint-single-badge-in-batch metadatas (list))))))

(define-public (get-badge-metadata (badge-id-param uint))
    (ok (map-get? badge-metadata badge-id-param)))

(define-public (get-owner (badge-id-param uint))
    (ok (nft-get-owner? badge-id badge-id-param)))

(define-public (get-last-badge-id)
    (ok (var-get last-badge-id)))
