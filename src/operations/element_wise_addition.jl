"""
    GrB_eWiseAdd(C, mask, accum, op, A, B, desc)

Generic method for element-wise matrix and vector operations: using set union.

`GrB_eWiseAdd` computes `C<Mask> = accum (C, A + B)`, where pairs of elements in two matrices (or two vectors)
are pairwise "added". The "add" operator can be any binary operator. With the plus operator,
this is the same matrix addition in conventional linear algebra. The pattern of the result T = A + B is
the set union of A and B. Entries outside of the union are not computed. That is, if both A(i, j) and B(i, j)
are present in the pattern of A and B, then T(i, j) = A(i, j) "+" B(i, j). If only A(i, j) is present
then T(i, j) = A (i, j) and the "+" operator is not used. Likewise, if only B(i, j) is in the pattern of B
but A(i, j) is not in the pattern of A, then T(i, j) = B(i, j). For a semiring, the mult operator is the
semiring's add operator.
"""
GrB_eWiseAdd(C, mask, accum, op::Abstract_GrB_BinaryOp, A::Abstract_GrB_Vector, B, desc) = GrB_eWiseAdd_Vector_BinaryOp(C, mask, accum, op, A, B, desc)
GrB_eWiseAdd(C, mask, accum, op::Abstract_GrB_Monoid, A::Abstract_GrB_Vector, B, desc) = GrB_eWiseAdd_Vector_Monoid(C, mask, accum, op, A, B, desc)
GrB_eWiseAdd(C, mask, accum, op::Abstract_GrB_Semiring, A::Abstract_GrB_Vector, B, desc) = GrB_eWiseAdd_Vector_Semiring(C, mask, accum, op, A, B, desc)
GrB_eWiseAdd(C, mask, accum, op::Abstract_GrB_BinaryOp, A::Abstract_GrB_Matrix, B, desc) = GrB_eWiseAdd_Matrix_BinaryOp(C, mask, accum, op, A, B, desc)
GrB_eWiseAdd(C, mask, accum, op::Abstract_GrB_Monoid, A::Abstract_GrB_Matrix, B, desc) = GrB_eWiseAdd_Matrix_Monoid(C, mask, accum, op, A, B, desc)
GrB_eWiseAdd(C, mask, accum, op::Abstract_GrB_Semiring, A::Abstract_GrB_Matrix, B, desc) = GrB_eWiseAdd_Matrix_Semiring(C, mask, accum, op, A, B, desc)

"""
    GrB_eWiseAdd_Vector_Semiring(w, mask, accum, semiring, u, v, desc)

Compute element-wise vector addition using semiring. Semiring's add operator is used.
`w<mask> = accum (w, u + v)`
"""
function GrB_eWiseAdd_Vector_Semiring(              # w<Mask> = accum (w, u+v)
        w::Abstract_GrB_Vector,                     # input/output vector for results
        mask::vector_mask_type,                     # optional mask for w, unused if NULL
        accum::accum_type,                          # optional accum for z=accum(w,t)
        semiring::Abstract_GrB_Semiring,            # defines '+' for t=u+v
        u::Abstract_GrB_Vector,                     # first input:  vector u
        v::Abstract_GrB_Vector,                     # second input: vector v
        desc::desc_type                             # descriptor for w and mask
)
end

"""
    GrB_eWiseAdd_Vector_Monoid(w, mask, accum, monoid, u, v, desc)

Compute element-wise vector addition using monoid.
`w<mask> = accum (w, u + v)`
"""
function GrB_eWiseAdd_Vector_Monoid(                # w<Mask> = accum (w, u+v)
        w::Abstract_GrB_Vector,                     # input/output vector for results
        mask::vector_mask_type,                     # optional mask for w, unused if NULL
        accum::accum_type,                          # optional accum for z=accum(w,t)
        monoid::Abstract_GrB_Monoid,                # defines '+' for t=u+v
        u::Abstract_GrB_Vector,                     # first input:  vector u
        v::Abstract_GrB_Vector,                     # second input: vector v
        desc::desc_type                             # descriptor for w and mask
)
end

"""
    GrB_eWiseAdd_Vector_BinaryOp(w, mask, accum, add, u, v, desc)

Compute element-wise vector addition using binary operator.
`w<mask> = accum (w, u + v)`
"""
function GrB_eWiseAdd_Vector_BinaryOp(              # w<Mask> = accum (w, u+v)
        w::Abstract_GrB_Vector,                     # input/output vector for results
        mask::vector_mask_type,                     # optional mask for w, unused if NULL
        accum::accum_type,                          # optional accum for z=accum(w,t)
        add::Abstract_GrB_BinaryOp,                 # defines '+' for t=u+v
        u::Abstract_GrB_Vector,                     # first input:  vector u
        v::Abstract_GrB_Vector,                     # second input: vector v
        desc::desc_type                             # descriptor for w and mask
)
end

"""
    GrB_eWiseAdd_Matrix_Semiring(C, Mask, accum, semiring, A, B, desc)

Compute element-wise matrix addition using semiring. Semiring's add operator is used.
`C<Mask> = accum (C, A + B)`
"""
function GrB_eWiseAdd_Matrix_Semiring(              # C<Mask> = accum (C, A+B)
    C::Abstract_GrB_Matrix,                         # input/output matrix for results
    Mask::matrix_mask_type,                         # optional mask for C, unused if NULL
    accum::accum_type,                              # optional accum for Z=accum(C,T)
    semiring::Abstract_GrB_Semiring,                # defines '+' for T=A+B
    A::Abstract_GrB_Matrix,                         # first input:  matrix A
    B::Abstract_GrB_Matrix,                         # second input: matrix B
    desc::desc_type                                 # descriptor for C, Mask, A, and B
)
end

"""
    GrB_eWiseAdd_Matrix_Monoid(C, Mask, accum, monoid, A, B, desc)

Compute element-wise matrix addition using monoid.
`C<Mask> = accum (C, A + B)`
"""
function GrB_eWiseAdd_Matrix_Monoid(            # C<Mask> = accum (C, A+B)
    C::Abstract_GrB_Matrix,                     # input/output matrix for results
    Mask::matrix_mask_type,                     # optional mask for C, unused if NULL
    accum::accum_type,                          # optional accum for Z=accum(C,T)
    monoid::Abstract_GrB_Monoid,                # defines '+' for T=A+B
    A::Abstract_GrB_Matrix,                     # first input:  matrix A
    B::Abstract_GrB_Matrix,                     # second input: matrix B
    desc::desc_type                             # descriptor for C, Mask, A, and B
)
end

"""
    GrB_eWiseAdd_Matrix_BinaryOp(C, Mask, accum, add, A, B, desc)

Compute element-wise matrix addition using binary operator.
`C<Mask> = accum (C, A + B)`
"""
function GrB_eWiseAdd_Matrix_BinaryOp(          # C<Mask> = accum (C, A+B)
    C::Abstract_GrB_Matrix,                     # input/output matrix for results
    Mask::matrix_mask_type,                     # optional mask for C, unused if NULL
    accum::accum_type,                          # optional accum for Z=accum(C,T)
    add::Abstract_GrB_BinaryOp,                 # defines '+' for T=A+B
    A::Abstract_GrB_Matrix,                     # first input:  matrix A
    B::Abstract_GrB_Matrix,                     # second input: matrix B
    desc::desc_type                             # descriptor for C, Mask, A, and B
)
end
