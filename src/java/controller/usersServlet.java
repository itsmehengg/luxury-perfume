package controller;

import dao.UserDAO;
import Model.Users;
import java.util.logging.Logger;
import java.util.logging.Level;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class usersServlet extends HttpServlet {
    private UserDAO userDao;
    private static final Logger LOGGER = Logger.getLogger(usersServlet.class.getName());

    @Override
    public void init() throws ServletException {
        userDao = new UserDAO();
        LOGGER.log(Level.INFO, "UserServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.log(Level.INFO, "doGet called with action: {0}", request.getParameter("action"));

        String action = request.getParameter("action");

        try {
            switch (action == null ? "list" : action) {
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                default: // "list"
                    listUsers(request, response);
                    break;
            }
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Error in doGet", ex);
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("users.jsp").forward(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    LOGGER.log(Level.INFO, "Listing users");
    try {
        List<Users> users = userDao.findByRole("customer");
        request.setAttribute("users", users);
        LOGGER.log(Level.INFO, "Users list size: {0}", users.size());
        RequestDispatcher dispatcher = request.getRequestDispatcher("users.jsp");
        dispatcher.forward(request, response);
    } catch (Exception e) {
        LOGGER.log(Level.SEVERE, "Error listing users", e);
        throw e;
    }
}


    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Users existingUser = userDao.findById(id);
        request.setAttribute("user", existingUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editUser.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDao.delete(id);
        response.sendRedirect("userServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                ? 0
                : Integer.parseInt(request.getParameter("id"));

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");

        Users user;
        if (id == 0) {
            user = new Users(name, email, password, phone, gender, role);
            userDao.create(user);
        } else {
            user = new Users(id, name, email, password, phone, gender, role);
            userDao.update(user);
        }

        response.sendRedirect("userServlet");
    }
}
