/**
 * @swagger
 * components:
 *   schemas:
 *     UserDetail:
 *       type: object
 *       required:
 *         - userId
 *         - username
 *         - email
 *       properties:
 *         userId:
 *           type: integer
 *           description: The unique identifier for the user
 *         username:
 *           type: string
 *           description: The username of the user
 *         email:
 *           type: string
 *           format: email
 *           description: Email address of the user
 *         firstName:
 *           type: string
 *           description: First name of the user
 *         lastName:
 *           type: string
 *           description: Last name of the user
 *         phone:
 *           type: string
 *           description: Contact phone number for the user
 *         address:
 *           type: string
 *           description: The physical address of the user
 *         role:
 *           type: string
 *           description: User role in the system
 */
export interface UserDetail {
  userId: number;
  username: string;
  email: string;
  firstName: string;
  lastName: string;
  phone: string;
  address: string;
  role: string;
}
