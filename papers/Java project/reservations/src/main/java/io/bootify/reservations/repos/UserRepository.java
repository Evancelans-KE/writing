package io.bootify.reservations.repos;

import io.bootify.reservations.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;


public interface UserRepository extends JpaRepository<User, Long> {
}
