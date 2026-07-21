const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

let users = [
  {
    id: 1,
    name: "Aarav Sharma",
    email: "aarav.sharma@example.in",
    phone: "+91-9876543210",
    website: "aaravsharma.in"
  },
  {
    id: 2,
    name: "Diya Patel",
    email: "diya.patel@example.in",
    phone: "+91-9823456712",
    website: "diyapatel.in"
  },
  {
    id: 3,
    name: "Rohan Verma",
    email: "rohan.verma@example.in",
    phone: "+91-9765412398",
    website: "rohanverma.in"
  },
  {
    id: 4,
    name: "Ananya Iyer",
    email: "ananya.iyer@example.in",
    phone: "+91-9956123478",
    website: "ananyaiyer.in"
  },
  {
    id: 5,
    name: "Vikram Singh",
    email: "vikram.singh@example.in",
    phone: "+91-9812345670",
    website: "vikramsingh.in"
  },
  {
    id: 6,
    name: "Meera Nair",
    email: "meera.nair@example.in",
    phone: "+91-9898076543",
    website: "meeranair.in"
  },
  {
    id: 7,
    name: "Karthik Reddy",
    email: "karthik.reddy@example.in",
    phone: "+91-9732104567",
    website: "karthikreddy.in"
  },
  {
    id: 8,
    name: "Sneha Kulkarni",
    email: "sneha.kulkarni@example.in",
    phone: "+91-9867001234",
    website: "snehakulkarni.in"
  },
  {
    id: 9,
    name: "Arjun Das",
    email: "arjun.das@example.in",
    phone: "+91-9901122334",
    website: "arjundas.in"
  },
  {
    id: 10,
    name: "Priya Menon",
    email: "priya.menon@example.in",
    phone: "+91-9845012765",
    website: "priyamenon.in"
  }
];

app.get("/", (req, res) => {
  res.send("User API is running");
});

app.get("/api/users", (req, res) => {
  res.status(200).json(users);
});

app.get("/api/users/:id", (req, res) => {
  const id = Number(req.params.id);
  const user = users.find((item) => item.id === id);

  if (!user) {
    return res.status(404).json({ message: "User Not Found" });
  }

  return res.status(200).json(user);
});

app.post("/api/users", (req, res) => {
  const { name, email, phone, website } = req.body;

  if (!name || !email || !phone || !website) {
    return res.status(400).json({
      message: "name, email, phone, and website are required"
    });
  }

  const nextId = users.length > 0 ? Math.max(...users.map((item) => item.id)) + 1 : 1;

  const newUser = {
    id: nextId,
    name,
    email,
    phone,
    website
  };

  users.push(newUser);
  return res.status(201).json(newUser);
});

app.put("/api/users/:id", (req, res) => {
  const id = Number(req.params.id);
  const userIndex = users.findIndex((item) => item.id === id);

  if (userIndex === -1) {
    return res.status(404).json({ message: "User Not Found" });
  }

  const { name, email, phone, website } = req.body;

  if (!name || !email || !phone || !website) {
    return res.status(400).json({
      message: "name, email, phone, and website are required"
    });
  }

  const updatedUser = {
    id,
    name,
    email,
    phone,
    website
  };

  users[userIndex] = updatedUser;
  return res.status(200).json(updatedUser);
});

app.delete("/api/users/:id", (req, res) => {
  const id = Number(req.params.id);
  const userIndex = users.findIndex((item) => item.id === id);

  if (userIndex === -1) {
    return res.status(404).json({ message: "User Not Found" });
  }

  users.splice(userIndex, 1);
  return res.status(204).send();
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
