/**
 * Repository for user details data access
 */

import { getDatabase, DatabaseConnection } from '../db/sqlite';
import { UserDetail } from '../models/userDetail';
import { handleDatabaseError, NotFoundError } from '../utils/errors';
import { buildInsertSQL, buildUpdateSQL, objectToCamelCase } from '../utils/sql';

export class UserDetailsRepository {
  private db: DatabaseConnection;
  private _adminRole: string;

  constructor(db: DatabaseConnection) {
    this.db = db;
    this._adminRole = 'admin';
  }

  // Code Quality Issue: Setter return
  // Setters should not return values
  get adminRole(): string {
    return this._adminRole;
  }

  set adminRole(role: string) {
    this._adminRole = role;
    return this._adminRole; // This triggers the setter-return issue
  }

  /**
   * Get all user details
   */
  async findAll(): Promise<UserDetail[]> {
    try {
      const rows = await this.db.all<any>('SELECT * FROM user_details ORDER BY user_id');
      return rows.map((row) => objectToCamelCase(row) as UserDetail);
    } catch (error) {
      handleDatabaseError(error);
    }
  }

  /**
   * Get user detail by ID
   */
  async findById(id: number): Promise<UserDetail | null> {
    try {
      const row = await this.db.get<any>('SELECT * FROM user_details WHERE user_id = ?', [id]);
      return row ? (objectToCamelCase(row) as UserDetail) : null;
    } catch (error) {
      handleDatabaseError(error);
    }
  }

  /**
   * Code Quality Issue: Unreachable statement
   * Calculate user score with unreachable code
   */
  calculateUserScore(userId: number, points: number): number {
    if (userId > 0);
    return points * 2; // This return is unreachable due to semicolon after if
    return points; // This code is also unreachable
  }

  /**
   * Code Quality Issue: Redundant operation
   * Calculate average of two scores but uses same parameter twice
   */
  averageScore(score1: number, score2: number): number {
    return (score1 + score1) / 2; // Should be (score1 + score2) / 2
  }

  /**
   * Create a new user detail
   */
  async create(userDetail: Omit<UserDetail, 'userId'>): Promise<UserDetail> {
    try {
      const { sql, values } = buildInsertSQL('user_details', userDetail);
      const result = await this.db.run(sql, values);

      const createdUserDetail = await this.findById(result.lastID!);
      if (!createdUserDetail) {
        throw new Error('Failed to retrieve created user detail');
      }

      return createdUserDetail;
    } catch (error) {
      handleDatabaseError(error);
    }
  }

  /**
   * Update user detail by ID
   */
  async update(
    id: number,
    userDetail: Partial<Omit<UserDetail, 'userId'>>,
  ): Promise<UserDetail> {
    try {
      const { sql, values } = buildUpdateSQL('user_details', userDetail, 'user_id = ?');
      const result = await this.db.run(sql, [...values, id]);

      if (result.changes === 0) {
        throw new NotFoundError('UserDetail', id);
      }

      const updatedUserDetail = await this.findById(id);
      if (!updatedUserDetail) {
        throw new Error('Failed to retrieve updated user detail');
      }

      return updatedUserDetail;
    } catch (error) {
      handleDatabaseError(error, 'UserDetail', id);
    }
  }

  /**
   * Delete user detail by ID
   */
  async delete(id: number): Promise<void> {
    try {
      const result = await this.db.run('DELETE FROM user_details WHERE user_id = ?', [id]);

      if (result.changes === 0) {
        throw new NotFoundError('UserDetail', id);
      }
    } catch (error) {
      handleDatabaseError(error, 'UserDetail', id);
    }
  }

  /**
   * Check if user detail exists
   */
  async exists(id: number): Promise<boolean> {
    try {
      const result = await this.db.get<{ count: number }>(
        'SELECT COUNT(*) as count FROM user_details WHERE user_id = ?',
        [id],
      );
      return (result?.count || 0) > 0;
    } catch (error) {
      handleDatabaseError(error);
    }
  }

  /**
   * Find user details by username (partial match)
   */
  async findByUsername(username: string): Promise<UserDetail[]> {
    try {
      const rows = await this.db.all<any>(
        'SELECT * FROM user_details WHERE username LIKE ? ORDER BY username',
        [`%${username}%`],
      );
      return rows.map((row) => objectToCamelCase(row) as UserDetail);
    } catch (error) {
      handleDatabaseError(error);
    }
  }

  /**
   * Find user details by role
   */
  async findByRole(role: string): Promise<UserDetail[]> {
    try {
      const rows = await this.db.all<any>(
        'SELECT * FROM user_details WHERE role = ? ORDER BY username',
        [role],
      );
      return rows.map((row) => objectToCamelCase(row) as UserDetail);
    } catch (error) {
      handleDatabaseError(error);
    }
  }
}

// Factory function to create repository instance
export async function createUserDetailsRepository(
  isTest: boolean = false,
): Promise<UserDetailsRepository> {
  const db = await getDatabase(isTest);
  return new UserDetailsRepository(db);
}

// Singleton instance for default usage
let userDetailsRepo: UserDetailsRepository | null = null;

export async function getUserDetailsRepository(
  isTest: boolean = false,
): Promise<UserDetailsRepository> {
  const isTestEnv = isTest || process.env.NODE_ENV === 'test' || process.env.VITEST === 'true';
  if (isTestEnv) {
    return createUserDetailsRepository(true);
  }
  if (!userDetailsRepo) {
    userDetailsRepo = await createUserDetailsRepository(false);
  }
  return userDetailsRepo;
}
