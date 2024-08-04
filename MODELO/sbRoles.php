<?php
// MODELO/sbRoles.php
class Roles {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getRoles() {
        $sql = "SELECT rol_id, rol_nombre FROM roles";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->get_result();

        $roles = array();
        while ($row = $result->fetch_assoc()) {
            $roles[] = $row;
        }

        return $roles;
    }
}
?>
